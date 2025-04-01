class CreateMapPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :map_permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.boolean :can_view, default: false
      t.boolean :can_create, default: false
      t.boolean :can_edit, default: false
      t.boolean :can_delete, default: false
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
