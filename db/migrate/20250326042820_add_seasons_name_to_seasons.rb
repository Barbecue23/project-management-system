class AddSeasonsNameToSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :seasons, :season_name, :string
  end
end
