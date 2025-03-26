class AddSeasonsNameToSeasons < ActiveRecord::Migration[8.0]
  def change
    add_column :seasons, :season_name, :string
  end
end
