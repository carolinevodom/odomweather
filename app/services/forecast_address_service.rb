require 'geocoder'
class ForecastAddressService < ApplicationService
  # This service is responsible for determining the zip code for caching, plus the latitude and longitude for the weather forecast API
  # It takes an address as input, which can be either a zip code or a full address
  # The address is passed in as a string, so we can use it directly in the geocoding service
  attr_reader :address

  def initialize(address)
    @address = address
  end


  # Determines the zip code for the forecast
  # We pass whatever address is given to us to the geocoding service
  # We can then take from the geocoding service the zip code, latitude, and longitude, since that's all we need.
  # Either way, we return the zip code, latitude, and longitude as a hash
    # Latitude and Longitude are necessary for the weather forecast API, and will come from the geocoding service if the address is not a zip code
  def call
    forecast_data = {}

    coordinates = Geocoder.search(@address).first
    # The GEOAPIFY service can look up via both zip codes and full addresses
    # It does not require any specific address format
    # It returns the most likely result as the first item in the json response, so we'll just take it
  

    if coordinates
      # The relevant structure for the GEOAPIFY response can be found in the documentation
      # https://apidocs.geoapify.com/docs/geocoding/
      forecast_data[:zip] = coordinates.data['properties']['postcode'] 
      forecast_data[:latitude] = coordinates.data['properties']['lat'].to_s
      forecast_data[:longitude] = coordinates.data['properties']['lon'].to_s
      # We need the latitude and longitude as strings for the weather forecast API
      # Zip comes back from the API as a string already
      return forecast_data
    else
      raise "Invalid address or unable to geocode"
      return false
    end

  end

end