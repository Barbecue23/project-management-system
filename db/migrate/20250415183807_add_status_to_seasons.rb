class AddStatusToSeasons < ActiveRecord::Migration[7.1]
  def change
    add_column :seasons, :status, :integer, default: 0, null: false
    add_index :seasons, :status
  end
end
