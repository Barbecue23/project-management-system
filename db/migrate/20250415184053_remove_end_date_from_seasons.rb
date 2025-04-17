class RemoveEndDateFromSeasons < ActiveRecord::Migration[7.1]
  def change
    remove_column :seasons, :end_date, :date
  end
end
