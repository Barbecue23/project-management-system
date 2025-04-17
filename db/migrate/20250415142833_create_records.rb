class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.string :title
      t.string :student_name
      t.string :year
      t.string :category
      t.string :record_type

      t.timestamps
    end
  end
end
