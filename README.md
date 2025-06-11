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
  

Setup Assumptions: Ruby and Rails at the aforementioned versions, and MySQL are already installed in the target environment

SETUP:
  Add .env file with GEOAPIFY API Key:
  `touch .env`
  Within the file generated/located above, add in your own GEOAPIFY API Key via the following line
  `GEOAPIFY_API_KEY = your_api_key_here`
  Documentation on the Geoapify API for geocoding, as well as the necessary link to generate an API key, can be found at https://apidocs.geoapify.com/docs/geocoding/



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
