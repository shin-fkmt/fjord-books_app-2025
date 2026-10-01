json.extract! daily_report, :id, :title, :body, :created_at, :updated_at
json.url daily_report_url(daily_report, format: :json)
