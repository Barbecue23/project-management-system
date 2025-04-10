class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def oauth2
    auth = request.env["omniauth.auth"]
    Rails.logger.info "🔁 OmniAuth Raw Params: #{auth.inspect}"
    Rails.logger.info "🔑 OAuth2 code (params): #{request.params['code']}"

    if auth.nil?
      Rails.logger.error "🔥 AUTH IS NIL!"
      redirect_to root_path, alert: "ข้อมูลการเข้าสู่ระบบไม่สมบูรณ์"
      return
    end

    # 🔥 ดึง userinfo จาก token เอง (เพราะ omniauth-oauth2 ไม่ทำให้)
    access_token = auth.credentials.token
    Rails.logger.info "OAuth2: Auth data = #{auth.inspect}"

    begin
      uri = URI("https://nidp.su.ac.th/nidp/oauth/nam/userinfo")
      userinfo = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        req = Net::HTTP::Get.new(uri)
        req["Authorization"] = "Bearer #{access_token}"
        res = http.request(req)
        JSON.parse(res.body)
      end

      Rails.logger.info "OAuth2: Userinfo = #{userinfo.inspect}"

      email = userinfo["email"]
      name = userinfo["name"]

      @user = User.find_or_create_by(email: email) do |user|
        user.name = name
        user.password = Devise.friendly_token[0, 20]
      end

      sign_in_and_redirect @user, event: :authentication
    rescue => e
      Rails.logger.error "OAuth2 login failed: #{e.message}"
      redirect_to root_path, alert: "เข้าสู่ระบบไม่สำเร็จ"
    end
  end

  def failure
    Rails.logger.error "OAuth2 authentication failure: #{request.env['omniauth.error']&.inspect}"
    Rails.logger.error "OAuth2 error type: #{request.env['omniauth.error.type']}"
    redirect_to root_path, alert: "การยืนยันตัวตนล้มเหลว"
  end
end
