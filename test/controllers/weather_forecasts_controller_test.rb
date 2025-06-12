require "test_helper"

class WeatherForecastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.cache.write('36453',
      {"currentTime" => "2025-06-12T00:03:44.626757451Z", "timeZone" => {"id" => "America/Chicago"}, "isDaytime" => true, "weatherCondition" => {"iconBaseUri" => "https://maps.gstatic.com/weather/v1/cloudy", "description" => {"text" => "Cloudy", "languageCode" => "en"}, "type" => "CLOUDY"}, "temperature" => {"degrees" => 27.5, "unit" => "CELSIUS"}, "feelsLikeTemperature" => {"degrees" => 30.7, "unit" => "CELSIUS"}, "dewPoint" => {"degrees" => 22.9, "unit" => "CELSIUS"}, "heatIndex" => {"degrees" => 30.7, "unit" => "CELSIUS"}, "windChill" => {"degrees" => 27.5, "unit" => "CELSIUS"}, "relativeHumidity" => 76, "uvIndex" => 0, "precipitation" => {"probability" => {"percent" => 24, "type" => "RAIN"}, "snowQpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}, "qpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}}, "thunderstormProbability" => 0, "airPressure" => {"meanSeaLevelMillibars" => 1017.62}, "wind" => {"direction" => {"degrees" => 200, "cardinal" => "SOUTH_SOUTHWEST"}, "speed" => {"value" => 5, "unit" => "KILOMETERS_PER_HOUR"}, "gust" => {"value" => 13, "unit" => "KILOMETERS_PER_HOUR"}}, "visibility" => {"distance" => 16, "unit" => "KILOMETERS"}, "cloudCover" => 94, "currentConditionsHistory" => {"temperatureChange" => {"degrees" => 3.2, "unit" => "CELSIUS"}, "maxTemperature" => {"degrees" => 30.5, "unit" => "CELSIUS"}, "minTemperature" => {"degrees" => 21, "unit" => "CELSIUS"}, "snowQpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}, "qpf" => {"quantity" => 2.0117, "unit" => "MILLIMETERS"}}}
    )
    #We'll write an example cache entry for the zip code 36453 to grab for testing
  end

  test "should get new" do
    get new_weather_forecast_url
    assert_response :success
  end

  test "should create weather_forecast" do
    assert_difference("WeatherForecast.count") do
      post weather_forecasts_url, params: { weather_forecast: { address: "12345" } }
    end

    assert_redirected_to weather_forecast_url(WeatherForecast.last)
  end

  test "should show weather_forecast" do
    get weather_forecast_url(@weather_forecast)
    assert_response :success
  end


end
