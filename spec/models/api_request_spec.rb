require 'spec_helper'
require_relative '../../app/models/api_request'

describe APIRequest do

  it 'returns lat and lng in an API response object' do
    VCR.use_cassette('api_request/lat_lng') do
      request = APIRequest.new
      response = request.get_lat_lng("Pearl Street, Boulder")
      expect(response.first).to eq 40.0179479
      expect(response[1]).to eq -105.2795348
    end
  end

  it 'returns first result in an API response object' do
    VCR.use_cassette('api_request/first_result') do
      request = APIRequest.new
      response = request.get_first_result("shine", "Pearl Street, Boulder")
      expect(response.name).to eq "Shine Restaurant and Gathering Place"
    end
  end

  it 'returns the photo in an API response object' do
    VCR.use_cassette('api_request/photo') do
      request = APIRequest.new
      response = request.get_first_result("shine", "Pearl Street, Boulder")
      photo_reference = response.photo_reference
      photo = request.get_photo(photo_reference)
      expect(photo).to include 'A HREF'
    end
  end

  it 'get_photo returns the photo info' do
    VCR.use_cassette('api_request/photo') do
      request = APIRequest.new
      response = request.get_first_result("shine", "Pearl Street, Boulder")
      photo_reference = response.photo_reference
      photo_info = request.get_photo(photo_reference)
      expect(photo_info).to include 'A HREF'
    end
  end

  it 'get_website returns the website info' do
    VCR.use_cassette('api_request/website') do
      request = APIRequest.new
      response = request.get_first_result("shine", "Pearl Street, Boulder")
      place_reference = response.place_reference
      website_info = request.get_website(place_reference)
      expect(website_info["result"]["website"]).to eq 'http://www.shineboulder.com/'
    end
  end

end