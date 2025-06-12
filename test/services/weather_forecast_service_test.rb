require 'test_helper'
class WeatherForecastServiceTest < ActiveSupport::TestCase
  setup do
    @latitude = "31.1234"
    @longitude = "-87.1234"
    @service = WeatherForecastService.new(@latitude, @longitude)
    @stubbed_response = {"currentTime" => "2025-06-12T00:41:59.053560683Z", "timeZone" => {"id" => "America/Chicago"}, "isDaytime" => true, "weatherCondition" => {"iconBaseUri" => "https://maps.gstatic.com/weather/v1/mostly_cloudy", "description" => {"text" => "Mostly cloudy", "languageCode" => "en"}, "type" => "MOSTLY_CLOUDY"}, "temperature" => {"degrees" => 79.6, "unit" => "FAHRENHEIT"}, "feelsLikeTemperature" => {"degrees" => 85.2, "unit" => "FAHRENHEIT"}, "dewPoint" => {"degrees" => 73.7, "unit" => "FAHRENHEIT"}, "heatIndex" => {"degrees" => 85.2, "unit" => "FAHRENHEIT"}, "windChill" => {"degrees" => 79.6, "unit" => "FAHRENHEIT"}, "relativeHumidity" => 82, "uvIndex" => 0, "precipitation" => {"probability" => {"percent" => 15, "type" => "RAIN"}, "snowQpf" => {"quantity" => 0, "unit" => "INCHES"}, "qpf" => {"quantity" => 0, "unit" => "INCHES"}}, "thunderstormProbability" => 0, "airPressure" => {"meanSeaLevelMillibars" => 1017.88}, "wind" => {"direction" => {"degrees" => 200, "cardinal" => "SOUTH_SOUTHWEST"}, "speed" => {"value" => 3, "unit" => "MILES_PER_HOUR"}, "gust" => {"value" => 7, "unit" => "MILES_PER_HOUR"}}, "visibility" => {"distance" => 10, "unit" => "MILES"}, "cloudCover" => 82, "currentConditionsHistory" => {"temperatureChange" => {"degrees" => 3.8, "unit" => "FAHRENHEIT"}, "maxTemperature" => {"degrees" => 86.9, "unit" => "FAHRENHEIT"}, "minTemperature" => {"degrees" => 69.8, "unit" => "FAHRENHEIT"}, "snowQpf" => {"quantity" => 0, "unit" => "INCHES"}, "qpf" => {"quantity" => 0.0792, "unit" => "INCHES"}}}
  end

  test "should build correct URL" do
    expected_url = "https://weather.googleapis.com/v1/currentConditions:lookup?key=#{ENV['GOOGLE_MAPS_WEATHER_API_KEY']}&location.latitude=#{@latitude}&location.longitude=#{@longitude}&unitsSystem=IMPERIAL"
    assert_equal expected_url, @service.build_url
  end

  test "should call API and return weather data" do
    # Stubbing the RestClient.get method to return a predefined response
    RestClient.stubs(:get).returns(stub(body: @stubbed_response.to_json))
      weather_data = @service.call
      assert weather_data.is_a?(Hash)
      assert weather_data.key?("currentTime")
      assert weather_data.key?("temperature")
      assert weather_data.key?("weatherCondition")
      assert_equal "FAHRENHEIT", weather_data["temperature"]["unit"]

      #As long as we test for some of the keys, we can be confident in our response since it's stubbed here.
  end
end