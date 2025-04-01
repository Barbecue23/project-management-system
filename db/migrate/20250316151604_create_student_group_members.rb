class CreateStudentGroupMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :student_group_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true
      t.integer :year_term, null: false
      t.references :advisor_group_member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
