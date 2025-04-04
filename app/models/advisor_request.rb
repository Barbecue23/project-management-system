class AdvisorRequest < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :advisor_group_member, class_name: "AdvisorGroupMember", foreign_key: "advisor_group_member_id"
end
