class AddStatusToStudentGroupMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :student_group_members, :status, :string, null: false, default: "accepted"
    add_index :student_group_members, :status
  end
end
