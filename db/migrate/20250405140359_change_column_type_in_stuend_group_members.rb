class ChangeColumnTypeInStuendGroupMembers < ActiveRecord::Migration[7.1]
  def change
    change_column :student_group_members, :year_term, :string
  end
end
