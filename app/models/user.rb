class User < ActiveRecord::Base
  DOMAIN = "theironyard.com"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  serialize :google_auth_data, JSON

  def self.from_omniauth auth
    email = auth.info.email
    raise "You must sign in with a #{DOMAIN} address" unless email.ends_with? DOMAIN
    where(email: email).first_or_create! do |u|
      u.password = SecureRandom.hex 64
      u.google_auth_id   = auth.id
      u.google_auth_data = auth.to_h
    end
  end
end
