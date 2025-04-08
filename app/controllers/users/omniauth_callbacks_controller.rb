# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
# You should configure your model like this:
# devise :omniauthable, omniauth_providers: [:twitter]

# You should also create an action method in this controller like this:
# def twitter
# end

# More info at:
# https://github.com/heartcombo/devise#omniauth

# GET|POST /resource/auth/twitter
# def passthru
#   super
# end

# GET|POST /users/auth/twitter/callback
# def failure
#   super
# end

# protected

# The path used when OmniAuth fails
# def after_omniauth_failure_path_for(scope)
#   super(scope)
# end
# app/controllers/users/omniauth_callbacks_controller.rb
def oauth2
  auth = request.env["omniauth.auth"]
  Rails.logger.debug "OmniAuth Auth: #{auth.inspect}"

  user = User.from_omniauth(auth)

  if user.persisted?
    sign_in_and_redirect user
  else
    Rails.logger.debug "User not persisted. Errors: #{user.errors.full_messages}"
    redirect_to root_path, alert: "Login failed: #{user.errors.full_messages.join(', ')}"
  end
end



  def failure
    redirect_to root_path
  end
end
