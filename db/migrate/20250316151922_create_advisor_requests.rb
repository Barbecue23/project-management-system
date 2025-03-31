class CreateAdvisorRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :advisor_requests do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :advisor_group_member, null: false, foreign_key: true
      t.string :status, null: false
      t.string :season_year_term, null: false
      t.string :message

      t.timestamps
    end
  end
end
