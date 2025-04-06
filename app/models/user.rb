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
  def self.from_omniauth(auth)
    user = where(email: auth.info.email.downcase).first_or_initialize

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
  

end    
