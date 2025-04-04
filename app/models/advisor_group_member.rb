class AdvisorGroupMember < ApplicationRecord
  belongs_to :advisor_group
  belongs_to :user
end
