# app/controllers/users/omniauth_callbacks_controller.rb
require "net/http"

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def oauth2
    auth = request.env["omniauth.auth"]

    # 🔥 ดึง userinfo จาก token เอง (เพราะ omniauth-oauth2 ไม่ทำให้)
    access_token = auth.credentials.token

    uri = URI("https://nidp.su.ac.th/nidp/oauth/nam/userinfo")
    userinfo = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req["Authorization"] = "Bearer #{access_token}"
      res = http.request(req)
      JSON.parse(res.body)
    end

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

  def failure
    redirect_to root_path
  end
end
