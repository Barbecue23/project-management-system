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
      where(email: auth.info.email).first_or_create do |user|
        user.name = auth.info.name
        user.password = Devise.friendly_token[0, 20] # ตั้งรหัสผ่านแบบสุ่ม
      end
    end
end
