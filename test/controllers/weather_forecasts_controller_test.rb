require "test_helper"

class WeatherForecastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.cache.write('36453',
      {"currentTime" => "2025-06-12T00:03:44.626757451Z", "timeZone" => {"id" => "America/Chicago"}, "isDaytime" => true, "weatherCondition" => {"iconBaseUri" => "https://maps.gstatic.com/weather/v1/cloudy", "description" => {"text" => "Cloudy", "languageCode" => "en"}, "type" => "CLOUDY"}, "temperature" => {"degrees" => 27.5, "unit" => "CELSIUS"}, "feelsLikeTemperature" => {"degrees" => 30.7, "unit" => "CELSIUS"}, "dewPoint" => {"degrees" => 22.9, "unit" => "CELSIUS"}, "heatIndex" => {"degrees" => 30.7, "unit" => "CELSIUS"}, "windChill" => {"degrees" => 27.5, "unit" => "CELSIUS"}, "relativeHumidity" => 76, "uvIndex" => 0, "precipitation" => {"probability" => {"percent" => 24, "type" => "RAIN"}, "snowQpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}, "qpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}}, "thunderstormProbability" => 0, "airPressure" => {"meanSeaLevelMillibars" => 1017.62}, "wind" => {"direction" => {"degrees" => 200, "cardinal" => "SOUTH_SOUTHWEST"}, "speed" => {"value" => 5, "unit" => "KILOMETERS_PER_HOUR"}, "gust" => {"value" => 13, "unit" => "KILOMETERS_PER_HOUR"}}, "visibility" => {"distance" => 16, "unit" => "KILOMETERS"}, "cloudCover" => 94, "currentConditionsHistory" => {"temperatureChange" => {"degrees" => 3.2, "unit" => "CELSIUS"}, "maxTemperature" => {"degrees" => 30.5, "unit" => "CELSIUS"}, "minTemperature" => {"degrees" => 21, "unit" => "CELSIUS"}, "snowQpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}, "qpf" => {"quantity" => 2.0117, "unit" => "MILLIMETERS"}}}
    )
    WeatherForecastService.stubs(:call).returns(
      {"currentTime" => "2025-06-12T00:03:44.626757451Z", "timeZone" => {"id" => "America/Chicago"}, "isDaytime" => true, "weatherCondition" => {"iconBaseUri" => "https://maps.gstatic.com/weather/v1/cloudy", "description" => {"text" => "Cloudy", "languageCode" => "en"}, "type" => "CLOUDY"}, "temperature" => {"degrees" => 27.5, "unit" => "CELSIUS"}, "feelsLikeTemperature" => {"degrees" => 30.7, "unit" => "CELSIUS"}, "dewPoint" => {"degrees" => 22.9, "unit" => "CELSIUS"}, "heatIndex" => {"degrees" => 30.7, "unit" => "CELSIUS"}, "windChill" => {"degrees" => 27.5, "unit" => "CELSIUS"}, "relativeHumidity" => 76, "uvIndex" => 0, "precipitation" => {"probability" => {"percent" => 24, "type" => "RAIN"}, "snowQpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}, "qpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}}, "thunderstormProbability" => 0, "airPressure" => {"meanSeaLevelMillibars" => 1017.62}, "wind" => {"direction" => {"degrees" => 200, "cardinal" => "SOUTH_SOUTHWEST"}, "speed" => {"value" => 5, "unit" => "KILOMETERS_PER_HOUR"}, "gust" => {"value" => 13, "unit" => "KILOMETERS_PER_HOUR"}}, "visibility" => {"distance" => 16, "unit" => "KILOMETERS"}, "cloudCover" => 94,
      "currentConditionsHistory" => {"temperatureChange" => {"degrees" => 3.2, "unit" => "CELSIUS"}, "maxTemperature" => {"degrees" => 30.5, "unit" => "CELSIUS"}, "minTemperature" => {"degrees" => 21, "unit" => "CELSIUS"}, "snowQpf" => {"quantity" => 0, "unit" => "MILLIMETERS"}, "qpf" => {"quantity" => 2.0117, "unit" => "MILLIMETERS"}}})    
    # We'll write an example cache entry for the zip code 36453 to grab for testing
    # We also stub out the two services we wrote in order to just test the controller logic here
  end

  test "should get new" do
    get new_weather_forecast_url
    assert_response :success
  end

  test "should get existing forecast for cached zip code" do
    ForecastAddressService.stubs(:call).returns({zip: "36453", latitude: "31.1234", longitude: "-87.1234"})

   
    assert Rails.cache.read('36453').present?
    post weather_forecasts_url, params: { weather_forecast: { address: "36453" } }
    assert_redirected_to weather_forecasts_url(params: { zip: "36453", cached: true })
      # We know based on the param whether or not we've actually pulled from the cache correctly
  end

  test "should get new forecast for non-cached zip code" do
    ForecastAddressService.stubs(:call).returns({zip: "99999", latitude: "31.1234", longitude: "-87.1234"})

    post weather_forecasts_url, params: { weather_forecast: { address: "99999" } }
    assert_redirected_to weather_forecasts_url(params: { zip: "99999", cached: false })
    # We know based on the param whether or not we've actually pulled from the cache correctly
  end

  test "should get index" do
    get weather_forecasts_url, params: { zip: "36453", cached: true }
    assert_response :success
    assert_not_nil assigns(:weather_forecast)
    assert_equal "36453", assigns(:zip)
    assert assigns(:cached)
    # We should have the weather forecast data in the response
    assert_includes @response.body, "Cloudy"
  end 



end
