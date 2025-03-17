class AdvisorGroup < ApplicationRecord
    belongs_to :owner, class_name: "User", foreign_key: "owner_id", optional: true
    has_many :advisor_group_members, dependent: :destroy
    has_many :users, through: :advisor_group_members
end
