class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  GH_RETURN = "after_github_authorize_return_path".freeze

  def google_oauth2
    user = User.from_omniauth auth
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
  rescue User::InvalidDomain => e
    redirect_to new_user_session_path, danger: e.message
  end

  def github
    current_user.attach_github_auth_data auth
    flash[:success] = "Github authorization complete"
    redirect_to session.delete(GH_RETURN) || profile_path
  end

private

  def auth
    request.env["omniauth.auth"]
  end
end
