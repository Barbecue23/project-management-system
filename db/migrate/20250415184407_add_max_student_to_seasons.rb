class AddMaxStudentToSeasons < ActiveRecord::Migration[7.1]
  def change
    add_column :seasons, :max_student, :integer
  end
end
