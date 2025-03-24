class AddPublishDateToNews < ActiveRecord::Migration[8.0]
  def change
    add_column :news, :publish_date, :datetime
  end
end
