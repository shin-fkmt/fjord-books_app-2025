class CreateMentions < ActiveRecord::Migration[8.0]
  def change
    create_table :mentions do |t|
      t.references :mentioning_report, foreign_key: { to_table: :reports }
      t.references :mentioned_report, foreign_key: { to_table: :reports }
      t.timestamps
      t.index %i[mentioning_report_id mentioned_report_id], unique: true
    end
  end
end
