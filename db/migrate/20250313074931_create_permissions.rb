class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.boolean :default_view, default: false
      t.boolean :default_create, default: false
      t.boolean :default_edit, default: false
      t.boolean :default_delete, default: false

      t.timestamps
    end
  end
end
