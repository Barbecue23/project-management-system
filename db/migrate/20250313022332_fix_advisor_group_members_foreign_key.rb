class FixAdvisorGroupMembersForeignKey < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :advisor_group_members, :groups

    add_foreign_key :advisor_group_members, :advisor_groups, column: :group_id

  end
end
