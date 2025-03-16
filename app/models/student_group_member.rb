class StudentGroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :season
  belongs_to :advisor_group_member
end
