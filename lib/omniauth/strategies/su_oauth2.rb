require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class SuOauth2 < OmniAuth::Strategies::OAuth2
      option :name, :su_oauth2

      option :client_options, {
        site: "https://nidp.su.ac.th",
        authorize_url: "/nidp/oauth/nam/authz",
        token_url: "/nidp/oauth/nam/token"
      }

      uid { raw_info["sub"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"],
          username: raw_info["preferred_username"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/nidp/oauth/nam/userinfo").parsed
      end
    end
  end
end
