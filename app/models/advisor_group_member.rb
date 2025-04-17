class AdvisorGroupMember < ApplicationRecord
  belongs_to :advisor_group
  belongs_to :user


  has_many :student_group_members
end
