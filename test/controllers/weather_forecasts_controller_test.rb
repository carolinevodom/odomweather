require "test_helper"

class WeatherForecastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_forecast = weather_forecasts(:one)
    # TODO: Update this to create a cached forecast to grab
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
