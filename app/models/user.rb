class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
          :omniauthable, omniauth_providers: [ :azure_oauth2 ]

    belongs_to :role, optional: true

    has_many :advisor_group_members
    has_many :advisor_groups, through: :advisor_group_members

    def self.from_omniauth(auth)
      email = auth.info.email.downcase

      unless email.ends_with?("@su.ac.th")
        raise "Unauthorized email domain"
      end

      user = where(email: email).first_or_initialize
      user.name = auth.info.name

      if user.new_record?
        user.password = Devise.friendly_token[0, 20]
      end

      if user.changed? || user.new_record?
        unless user.save
          Rails.logger.debug "User save failed: #{user.errors.full_messages}"
        end
      end

      user
    end
    validates :email,
    presence: { message: "กรุณากรอกอีเมล" },
    uniqueness: { message: "อีเมลนี้มีในระบบแล้ว" },
    format: { with: /\A[\w+\-.]+@su\.ac\.th\z/i, message: "ต้องใช้อีเมล @su.ac.th เท่านั้น" }

    validates :name,
    presence: { message: "กรุณากรอกชื่อ" }
end
