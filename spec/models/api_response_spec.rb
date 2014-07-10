require 'spec_helper'
require_relative '../../app/models/api_response'

describe 'APIResponse' do

  before :each do
    VCR.use_cassette('api_response/request') do
      @api_response_object = APIRequest.new.get_first_result("shine", "Pearl Street, Boulder")
    end
  end

  it "returns a rating for a specific restaurant" do
    VCR.use_cassette('api_response/rating') do
      rating = @api_response_object.rating
      expect(rating).to eq 3.9
    end
  end

  it "returns an address for a specific restaurant" do
    VCR.use_cassette('api_response/address') do
      rating = @api_response_object.address
      expect(rating).to eq "2027 13th St, Boulder"
    end
  end

  it "returns a photo for a specific restaurant" do
    VCR.use_cassette('api_response/photo') do
      photo = @api_response_object.photo
      expect(photo).to eq "https://lh5.googleusercontent.com/-bPP-ol8Sb-o/UjEkAUKaoLI/AAAAAAAAD4Y/AqRIATez_v8/s1600-w341/photo.jpg"
    end
  end

  it "returns a website for a specific restaurant" do
    VCR.use_cassette('api_response/website') do
      website = @api_response_object.website
      expect(website).to eq "http://www.shineboulder.com/"
    end
  end

  it "returns a name for a specific restaurant" do
    VCR.use_cassette('api_response/name') do
      name = @api_response_object.name
      expect(name).to eq "Shine Restaurant and Gathering Place"
    end
  end

  it "returns false if there are no google matches" do
    VCR.use_cassette('api_response/googlematches') do
      api_no_match = APIRequest.new.get_first_result("afdsa", "Pearl Street, Boulder")
      matches = api_no_match.matches?
      expect(matches).to eq false
    end
  end

  it "returns the attributes all at once in a hash" do
    VCR.use_cassette('api_response/to_h') do
      attributes = @api_response_object.to_h
      expect(attributes[:rating].class).to eq Float
      expect(attributes[:address].class).to eq String
      expect(attributes[:name].class).to eq String
    end
  end

end