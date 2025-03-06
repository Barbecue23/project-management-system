class NewsGroup < ApplicationRecord
  belongs_to :news
  belongs_to :advisor_group, class_name: "AdvisorGroup", foreign_key: "advisor_group_id"
end
