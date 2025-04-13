class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def oauth2
    auth = request.env["omniauth.auth"]
    access_token = auth.credentials.token

    begin
      uri = URI("https://nidp.su.ac.th/nidp/oauth/nam/tokeninfo")
      userinfo = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        req = Net::HTTP::Get.new(uri)
        req["Authorization"] = "Bearer #{access_token}"
        res = http.request(req)
        Rails.logger.info "Tokeninfo response raw body = #{res.body}"
        JSON.parse(res.body)
      end

      uid = userinfo["user_id"]
      auth.uid = uid
      auth.info ||= OmniAuth::AuthHash::InfoHash.new
      auth.info.email = "#{uid}@su.ac.th"  # ปลอม email ไว้ก่อน
      auth.info.name  = uid

      @user = User.from_omniauth(auth)
      sign_in_and_redirect @user, event: :authentication
    rescue => e
      Rails.logger.error "OAuth2 login failed: #{e.message}"
      redirect_to root_path, alert: "เข้าสู่ระบบไม่สำเร็จ"
    end
  end


  def failure
    redirect_to root_path, alert: "การยืนยันตัวตนล้มเหลว"
  end
end
