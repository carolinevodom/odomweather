# README

Welcome to OdomWeather

This app was built as part of a technical assessment, and may be deprecated without notice. It was initialized on June 8th, 2025.

This app accepts an input address and returns the current weather conditions for the address supplied.
For US Addresses, the result is cached, and the cache value is returned for queries less than 30 minutes after the initial request for the location zipcode. The weather conditions are queried from an external API if no acceptable cache entry is found. 

Only US Addresses are accepted on first iteration - should time allow, on subsequent iterations non-US addresses will be accepted, and weather data will be queried from an external API upon every request to reduce complexity.
(Note: Only US addresses are utilize zip codes in the manner required by the project specifications for caching.)

Ruby Version: 3.4.2
Rails Version: 8.0.2

Database: MySQL 

Relevant Gems:
  * Geocoder (https://www.rubydoc.info/gems/geocoder/1.3.7)
    - For Geocoding the provided address into latitude/longitude for the weather API
  * RestClient (https://www.rubydoc.info/gems/rest-client/2.1.0)
    - To make the calls to the Google Weather API friendlier.
  

Setup Assumptions: Ruby and Rails at the aforementioned versions, and MySQL are already installed in the target environment.
MySQL user is present with appropriate credentials (https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql)

SETUP:
  Add MySQL user credentials to `config/database.yml` in the username and password fields of the `default` section

  Add .env file with GEOAPIFY and Google Maps Weather API Keys:
  `touch .env`
  Within the file generated/located above, add in your own GEOAPIFY API Key via the following line
  `GEOAPIFY_API_KEY = your_api_key_here`
  *Documentation on the Geoapify API for geocoding, as well as the necessary link to generate an API key, can be found at https://apidocs.geoapify.com/docs/geocoding/
  (Note: GEOAPIFY API at the free tier allows for a maximum of 3,000 requests per day. This would be a potential concern in a real production app, but is more than adequate for a test scenario.)
  * Documentation on the Google Maps Weather API useage, as well as the link to create a project and API key, can be found at https://developers.google.com/maps/documentation/weather/get-api-key
  (Note: The Google Maps API at the free tier allows for a maximum of 1000 requests per day. This is another potential concern in a real production app, but is more than adequeate for this scenario.)




Performance Considerations:
  * The application does make an api call to the geocoder every time an address is input. This is not ideal, but does keep us from requiring any dedicated database space. 
    - A spike could be considered into storing the latitude/longitude data for commonly requested zip codes to reduce the amount of api calls. 





This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
