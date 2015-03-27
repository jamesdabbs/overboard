class User < ActiveRecord::Base
  DOMAIN = "theironyard.com"
  class InvalidDomain < StandardError; end

  class GithubNotAuthorizedError < StandardError; end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :database_authenticatable, :registerable,
  # :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]

  serialize :google_auth_data, JSON
  serialize :github_auth_data, JSON

  has_one :employee
  has_many :courses

  def self.from_omniauth auth
    email = auth.info.email
    unless email.ends_with? DOMAIN
      raise InvalidDomain, "You must sign in with a #{DOMAIN} address"
    end

    where(email: email).first_or_create! do |u|
      u.name     = auth.info.name
      u.password = SecureRandom.hex 64

      u.google_auth_id   = auth.id
      u.google_auth_data = auth.to_h
    end.tap do |u|
      Employee.where(email: u.email, user_id: nil).update_all user_id: u.id
    end
  end

  def active_course
    instructor.try :active_course
  end

  def instructs? course
    course.instructor.user_id == id
  end

  def github_authorized?
    github_auth_data.present?
  end

  def attach_github_auth_data auth
    update github_auth_id: auth.uid, github_auth_data: auth.to_h
  end

  def github_access_token
    github_auth_data["credentials"]["token"]
  end

  def octoclient
    raise GithubNotAuthorizedError, "You must authorize with Github" unless github_authorized?
    @_octoclient ||= Octokit::Client.new(access_token: github_access_token)
  end

  def github_teams
    @_github_teams ||= octoclient.organizations.each_with_object({}) do |org, teams|
      teams[org] = octoclient.organization_teams org.login
    end
  end

  def github_team_choices
    github_teams.flat_map do |org, teams|
      teams.map { |team| ["#{org.login}/#{team.slug}", team.id] }
    end
  end

  def journals
    employee.try :journals
  end
end
