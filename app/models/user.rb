class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [ :oauth2 ]

    belongs_to :role, optional: true

    has_many :advisor_group_members
    has_many :advisor_groups, through: :advisor_group_members

    def self.from_omniauth(auth)
      # ดึงข้อมูล userinfo เพิ่มเติม หากไม่มี email มา
      email = auth.info.email
      name = auth.info.name || auth.info.nickname || auth.uid

      if email.blank?
        begin
          uri = URI("https://nidp.su.ac.th/nidp/oauth/nam/userinfo")
          userinfo = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Get.new(uri)
            req["Authorization"] = "Bearer #{auth.credentials.token}"
            res = http.request(req)
            JSON.parse(res.body)
          end

          email = userinfo["email"] || "#{userinfo["sub"]}@su.ac.th"
          name = userinfo["name"] || name
        rescue => e
          Rails.logger.warn "Userinfo fetch failed: #{e.message}"
          email ||= "#{auth.uid}@su.ac.th"
        end
      end

      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.email = email
        user.name = name
        user.password ||= Devise.friendly_token[0, 20]
        user.save!
      end
    end
end
