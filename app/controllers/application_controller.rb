class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  protect_from_forgery with: :exception

  # เพิ่มบรรทัดนี้เพื่อ skip CSRF เฉพาะ callback จาก OmniAuth
  skip_before_action :verify_authenticity_token, if: -> { request.path.start_with?("/users/auth/") }

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || some_dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
