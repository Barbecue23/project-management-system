require Rails.root.join("lib/omniauth/strategies/su_oauth2")

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :su_oauth2,
    "905347a0-3f96-485e-be7a-f9b63b14bc12",
    "GLqNi2vbZQw3vYY-NX5Dc5H9kHcdyd-CJqXq02iDfpz3lPYNhTU2d1mXnRcfTh4rqAvnesBihg4xBjDX67WKxw",
    {
      scope: "openid profile email",
      redirect_uri: "https://fingers-mn-sun-rights.trycloudflare.com/users/auth/oauth2/callback"
    }
end
