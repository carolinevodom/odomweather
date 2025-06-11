class ForecastAddressService < ApplicationService
  attr_reader :address

  def initialize(address)
    @address = address
  end


  # Determines the zip code for the forecast
  # If the address is a zip code, we can use it directly 
  # If the address is a full address, we use a geocoding service to get the zip code
  # Either way, we return the zip code, latitude, and longitude as a hash
    # Latitude and Longitude are necessary for the weather forecast API, and will come from the geocoding service if the address is not a zip code
  def call(address)
    forecast_data = {}

    coordinates = Geocoder.search(address).first
    #The GEOAPIFY service can look up via both zip codes and full addresses
    # It does not require any specific address format

    if coordinates
      # Need to look at the data structure returned by the geocoding service to grab just what we want
    else
      raise "Invalid address or unable to geocode"
    end

    forecast_data
  end

end