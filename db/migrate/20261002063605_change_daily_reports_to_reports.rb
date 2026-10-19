class ChangeDailyReportsToReports < ActiveRecord::Migration[8.0]
  def change
    rename_table :daily_reports, :reports
  end
end
