class AddExpertiseToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :expertise, :string
  end
end
