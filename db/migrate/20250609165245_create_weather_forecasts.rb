class CreateWeatherForecasts < ActiveRecord::Migration[8.0]
  def change
    create_table :weather_forecasts do |t|
      t.integer :zip
      t.integer :current_temp
      t.integer :high_today
      t.integer :low_today
      t.integer :uv_index

      t.timestamps
    end
  end
end
