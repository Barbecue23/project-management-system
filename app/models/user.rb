class User < ApplicationRecord
    belongs_to :role, optional: true

    has_many :advisor_group_members
    has_many :advisor_groups, through: :advisor_group_members
end
