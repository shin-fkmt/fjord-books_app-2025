class CreateDailyReports < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_reports do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
