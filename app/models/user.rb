class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [ :oauth2 ]

    belongs_to :role, optional: true

    has_many :advisor_group_members
    has_many :advisor_groups, through: :advisor_group_members

  # app/models/user.rb
  # def self.from_omniauth(auth)
  #   email = auth.info.email || auth.dig(:extra, :raw_info, :email)
  #   return nil unless email

  #   user = where(email: email.downcase).first_or_initialize
  #   user.name = auth.info.name if auth.info.name.present?

  #   if user.new_record?
  #     user.password = Devise.friendly_token[0, 20]
  #   end

  #   user.save if user.changed?
  #   user
  # end
  def self.from_omniauth(auth)
    # หา user จาก provider + uid หรือ email แล้วลงชื่อเข้าใช้
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # เพิ่ม field อื่นถ้าจำเป็น
    end
  end
end
