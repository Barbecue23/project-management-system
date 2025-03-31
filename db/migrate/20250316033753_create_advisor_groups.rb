class CreateAdvisorGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :advisor_groups do |t|
      t.string :group_name
      t.integer :owner_id

      t.timestamps
    end
  end
end
