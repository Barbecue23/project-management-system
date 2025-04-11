def oauth2
  auth = request.env["omniauth.auth"]
  if auth.blank?
    redirect_to root_path, alert: "ไม่สามารถรับข้อมูลผู้ใช้ได้"
    return
  end

  Rails.logger.info "OAuth2: AUTH = #{auth.inspect}"

  @user = User.from_omniauth(auth)
  if @user.persisted?
    sign_in_and_redirect @user, event: :authentication
  else
    redirect_to root_path, alert: "ไม่สามารถเข้าสู่ระบบได้"
  end
end

def failure
  redirect_to root_path, alert: "การยืนยันตัวตนล้มเหลว"
end
