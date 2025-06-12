require 'rest-client'
class WeatherForecastService < ApplicationService
  # This service will call the Google Maps Weather API to get the current weather forecast
  # It requires latitude and longitude as input parameters

  # The latitude and longitude are passed in as strings, so we can use them directly in the URL
  # The API key is stored in an environment variable for security
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    puts 'in the API call'
    #Here we call the API to actually get the weather forecast data

    api_response = RestClient.get(build_url)
    weather_data = JSON.parse(api_response.body)
    puts "Weather data received: #{weather_data}"
    # For this first iteration, we just want the current temp + daily high and low
    return weather_data
  end

  # The URL is built according to the Google Maps Weather API documentation
  # https://developers.google.com/maps/documentation/weather/current-conditions
  def build_url
    your_api_key = ENV['GOOGLE_MAPS_WEATHER_API_KEY']
    base_url = 'https://weather.googleapis.com/v1/currentConditions:lookup?key='
    "#{base_url}#{your_api_key}&location.latitude=#{@latitude}&location.longitude=#{@longitude}&unitsSystem=IMPERIAL"
    #We specify the units system as IMPERIAL to get Fahrenheit temperatures
  end
end