class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from User::GithubNotAuthorizedError do |e|
    flash[:alert] = e.message.present? ? e.message : "You must authorize with Github"
    session[OmniauthCallbacksController::GH_RETURN] = request.path
    redirect_to profile_path
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
