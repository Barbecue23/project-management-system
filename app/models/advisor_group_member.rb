class AdvisorGroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def owner?
    is_owner
  end
end
