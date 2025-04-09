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
def su_oauth
  auth = request.env["omniauth.auth"]
  user = User.find_or_create_by(uid: auth.uid) do |u|
    u.email = auth.info.email
    u.name = auth.info.name || auth.info.nickname
    u.password = Devise.friendly_token[0, 20]
  end

  if user.persisted?
    sign_in_and_redirect user, event: :authentication
  else
    session["devise.su_oauth_data"] = auth
    redirect_to new_user_registration_url
  end
end



  def failure
    redirect_to root_path
  end
end
