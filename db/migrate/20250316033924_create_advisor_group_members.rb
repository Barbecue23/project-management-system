class CreateAdvisorGroupMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :advisor_group_members do |t|
      t.references :advisor_group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :is_owner

      t.timestamps
    end
  end
end
