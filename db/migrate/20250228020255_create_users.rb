class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :student_id
      t.string :faculty
      t.string :major
      t.string :email

      t.timestamps
    end
  end
end
