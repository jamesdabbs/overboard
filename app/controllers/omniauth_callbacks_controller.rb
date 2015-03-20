class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth request.env["omniauth.auth"]
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
  rescue User::InvalidDomain => e
    redirect_to new_user_session_path, danger: e.message
  end
end
