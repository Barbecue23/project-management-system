class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_oauth2
    auth = request.env["omniauth.auth"]

    begin
      user = User.from_omniauth(auth)
    rescue => e
      redirect_to root_path, alert: "Login failed: #{e.message}" and return
    end

    if user.persisted?
      sign_in_and_redirect user
    else
      redirect_to root_path, alert: "Login failed: #{user.errors.full_messages.join(", ")}"
    end
  end


  def failure
    error_type = request.env["omniauth.error.type"]
    error_message = request.env["omniauth.error"]&.message

    flash[:alert] = "ยืนยันตัวตนล้มเหลว: #{error_type} - #{error_message}"
    redirect_to root_path
  end
end
