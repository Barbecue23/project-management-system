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
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.email = "#{auth.uid}@su.ac.th" # ใช้ email ปลอม หรือจะหา email จริงจากแหล่งอื่นภายหลัง
        user.name = auth.uid # หรือถ้ามีระบบที่ lookup ชื่อจริงจาก uid ก็ทำเพิ่มภายหลังได้
        user.password ||= Devise.friendly_token[0, 20]
        user.save!
      end
    end
end
