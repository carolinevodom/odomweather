Preface: This file exists to act as a place to store/track the various objectives and requirements for this project. In essence, this file will serve as a pseudo-Jira board for project development.


* Select and implement external tool for weather forecasts
  * Should be able to return current temp, weather conditions, as well as daily high/low and extended forecast of some kind.
  * Perhaps Google Weather API? https://developers.google.com/maps/documentation/weather/daily-forecast

* Set Up Geocoding Gem/API - Initial Setup Complete
  * The Google Weather API requires the address to be passed through as a latitude/longitude pair. Also need to be able to get the zip code if one isn't provided.
  - Utilizing the GEOAPIFY Api, we get full address OR Zip code entry for free, making the input friendlier for users.
  - Geocoder gem is added to gem file.
  - Geocoder File lists GEOAPIFY as the geocoder to use.
  - GEOAPIFY API key has been obtained and lives in a `.env` file, managed by dotenv gem.

* Set up DB Objects - First Pass Complete
  * DB Object in question should store weather conditions, zip code, created at, updated at.
  - generated scaffold for class "WeatherForecast" to create files, will weed unnecessary files and migrate in additional fields as necessary.
  - included current temp, daily high/low

* Set Up Input UI
  * UI Should take in Street Address, City, State, Zip, Country (Maybe drop-down for country? Or two partials y/n "Is a US Address?) Start with US Address Portion

* US Address process
  * Take in address, filter down to zip code (if not just a zip)
  * Potentially Transform Address to Latitude/Longitude (if using Google Weather API)
  * Request from API Weather Data for given address
  * Return Weather Data on Page

* Set Up Caching by Zip Code
  * Cached value should be stored for 30 minutes

* Later: Set up non-US address section
  
* Later: Adjust UI for aesthetic appeal.

* 