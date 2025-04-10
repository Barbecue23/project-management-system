class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def oauth2
    auth = request.env["omniauth.auth"]

    unless auth
      Rails.logger.error "OAuth2 callback missing auth data"
      redirect_to root_path, alert: "ข้อมูลการเข้าสู่ระบบไม่สมบูรณ์"
      return
    end

    # 🔥 ดึง userinfo จาก token เอง (เพราะ omniauth-oauth2 ไม่ทำให้)
    access_token = auth.credentials.token

    # Log OAuth2 auth data
    Rails.logger.info "OAuth2: Auth data = #{auth.inspect}"
    # แสดงข้อมูลดิบไว้ก่อนสำหรับ debug
    render plain: auth.to_yaml and return

    begin
      uri = URI("https://nidp.su.ac.th/nidp/oauth/nam/userinfo")
      userinfo = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        req = Net::HTTP::Get.new(uri)
        req["Authorization"] = "Bearer #{access_token}"
        res = http.request(req)
        JSON.parse(res.body)
      end

      # Log userinfo data
      Rails.logger.info "OAuth2: Userinfo = #{userinfo.inspect}"

      email = userinfo["email"]
      name = userinfo["name"]

      Rails.logger.info "OAuth2: Email = #{email}, Name = #{name}"

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
    Rails.logger.error "OAuth2 authentication failure: #{failure_message}"
    redirect_to root_path, alert: "การยืนยันตัวตนล้มเหลว"
  end
end
