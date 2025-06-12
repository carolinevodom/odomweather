json.extract! weather_forecast, :id, :zip, :current_temp, :high_today, :low_today, :uv_index, :created_at, :updated_at
json.url weather_forecast_url(weather_forecast, format: :json)
