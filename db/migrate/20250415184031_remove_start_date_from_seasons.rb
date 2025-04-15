class RemoveStartDateFromSeasons < ActiveRecord::Migration[7.1]
  def change
    remove_column :seasons, :start_date, :date
  end
end
