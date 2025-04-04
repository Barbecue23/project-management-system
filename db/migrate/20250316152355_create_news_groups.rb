class CreateNewsGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :news_groups do |t|
      t.references :news, null: false, foreign_key: true
      t.references :advisor_group, null: false, foreign_key: { to_table: :advisor_groups }
      t.string :created_by

      t.timestamps
    end
  end
end
