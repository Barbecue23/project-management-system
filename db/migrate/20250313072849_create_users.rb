class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :student_id
      t.string :email
      t.string :faculty
      t.string :major

      t.timestamps
    end
  end
end
