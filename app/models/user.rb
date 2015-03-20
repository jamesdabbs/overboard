class User < ActiveRecord::Base
  DOMAIN = "theironyard.com"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :database_authenticatable, :registerable,
  # :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  serialize :google_auth_data, JSON

  has_one :instructor
  has_many :courses

  def self.from_omniauth auth
    email = auth.info.email
    raise "You must sign in with a #{DOMAIN} address" unless email.ends_with? DOMAIN
    where(email: email).first_or_create! do |u|
      u.name     = auth.info.name
      u.password = SecureRandom.hex 64

      u.google_auth_id   = auth.id
      u.google_auth_data = auth.to_h
    end.tap do |u|
      Instructor.where(email: u.email, user_id: nil).update_all user_id: u.id
    end
  end

  def active_course
    instructor.try :active_course
  end

  def instructs? course
    course.instructor.user_id == id
  end
end
