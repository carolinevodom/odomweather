require 'test_helper'
require 'ostruct'
class ForecastAddressServiceTest < ActiveSupport::TestCase
  setup do
    @service = ForecastAddressService.new("36453")
    @ideal_response = { zip: "36453", latitude: "31.1234", longitude: "-87.1234" }
  end

  test "should return zip, latitude, and longitude for valid zip code" do
    fake_geocoder_result = [
      OpenStruct.new( data: {"type" => "Feature", "properties" => {"datasource" => {"sourcename" => "openstreetmap", "attribution" => "© OpenStreetMap contributors", "license" => "Open Database License", "url" => "https://www.openstreetmap.org/copyright"}, "name" => "36453", "ref" => "36453", "country" => "United States", "country_code" => "us", "state" => "Alabama", "county" => "Coffee County", "city" => "Kinston", "postcode" => "36453", "iso3166_2" => "US-AL", "lon" => -87.1234, "lat" => 31.1234, "state_code" => "AL", "result_type" => "postcode", "formatted" => "Kinston, AL 36453, United States of America", "address_line1" => "Kinston, AL 36453", "address_line2" => "United States of America", "timezone" => {"name" => "America/Chicago", "offset_STD" => "-06:00", "offset_STD_seconds" => -21600, "offset_DST" => "-05:00", "offset_DST_seconds" => -18000, "abbreviation_STD" => "CST", "abbreviation_DST" => "CDT"}, "plus_code" => "863M6RFV+V2", "rank" => {"importance" => 0.12000999999999995, "popularity" => 1.3896062322405274, "confidence" => 1, "confidence_city_level" => 1, "match_type" => "full_match"}, "place_id" => "51b94ac164148a55c059b25b837686393f40c0020792030833363435332b7573"}, "geometry" => {"type" => "Point", "coordinates" => [-86.157494725, 31.22470799166667]}, "bbox" => [-86.2074947, 31.174708, -86.1074947, 31.274708]})
    ]
    Geocoder.stubs(:search).with("36453").returns(fake_geocoder_result)
    
    result = @service.call
    assert_equal @ideal_response, result
  end
  # The GEOAPIFY service can look up via both zip codes and full addresses
  # It can handle most any input, so I'm not worried about the failure case.

end
