class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :title
      t.string :content
      t.boolean :is_public
      t.string :created_by

      t.timestamps
    end
  end
end
