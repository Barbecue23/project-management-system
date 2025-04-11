class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def oauth2
    auth = request.env["omniauth.auth"]
    Rails.logger.debug "=== OIDC Auth Hash ==="
  Rails.logger.debug auth.inspect
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.su_oidc_data"] = auth.except(:extra)
      redirect_to new_user_registration_url, alert: "ไม่สามารถเข้าสู่ระบบได้"
    end
  end

  def failure
    Rails.logger.error "OAuth2 authentication failure: #{request.env['omniauth.error']&.inspect}"
    Rails.logger.error "OAuth2 error type: #{request.env['omniauth.error.type']}"
    redirect_to root_path, alert: "การยืนยันตัวตนล้มเหลว"
  end
end
