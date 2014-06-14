require 'spec_helper'
require 'requests/rails_helper'
require_relative '../../app/models/places_search'

describe 'PlacesSearch' do

  before :each do
    @key = ENV['GOOGLE_API_KEY']
    @search = PlacesSearch.new(@key, "Shine", "Pearl Street, Boulder")
  end

  it "returns a rating for a specific restaurant" do
    VCR.use_cassette('places_search/rating') do
      rating = @search.get_rating
      expect(rating).to eq 3.9
    end
  end

  it "returns an address for a specific restaurant" do
    VCR.use_cassette('places_search/address') do
      rating = @search.get_address
      expect(rating).to eq "2027 13th St, Boulder"
    end
  end

  it "returns a photo for a specific restaurant" do
    VCR.use_cassette('places_search/photo') do
      rating = @search.get_photo
      expect(rating).to eq "https://lh5.googleusercontent.com/-bPP-ol8Sb-o/UjEkAUKaoLI/AAAAAAAAD4Y/AqRIATez_v8/s1600-w341/photo.jpg"
    end
  end

  it "returns a website for a specific restaurant" do
    VCR.use_cassette('places_search/website') do
      rating = @search.get_website
      expect(rating).to eq "http://www.shineboulder.com/"
    end
  end

  it "returns a name for a specific restaurant" do
    VCR.use_cassette('places_search/name') do
      name = @search.get_name
      expect(name).to eq "Shine Restaurant and Gathering Place"
    end
  end

  it "returns false if there are no google matches" do
    VCR.use_cassette('places_search/googlematches') do
      search = PlacesSearch.new(@key, "bhew", "Pearl Street, Boulder")
      matches = search.matches?
      expect(matches).to eq false
    end
  end

  it "returns latitude and longitude for a neighborhood" do
    VCR.use_cassette('places_search/coordinates') do
      search = PlacesSearch.new(@key, "bhew", "Pearl Street, Boulder")
      coordinates = search.get_json_restaurant_data(true)
      expect(coordinates).to eq ({ :latitude=>40.0179479, :longitude=>-105.2795348 })
    end
  end

  it "returns latitude and longitude for a specific restaurant" do
    VCR.use_cassette('places_search/coordinates') do
      search = PlacesSearch.new(@key, "Centro", "Pearl Street, Boulder")
      coordinates = search.get_restaurant_coordinates
      expect(coordinates).to eq ({ "lat"=>40.017196, "lng"=>-105.282545 })
    end
  end

end