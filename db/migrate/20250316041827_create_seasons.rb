class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.jsonb :seasons_detail, default: {}, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
