class CreateAdvisorGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :advisor_groups do |t|
      t.string :group_name
      t.references :owner_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
