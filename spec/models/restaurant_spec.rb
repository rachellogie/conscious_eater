require 'spec_helper'


describe Restaurant do

  describe 'validations' do
    before do
      @restaurant = Restaurant.new(name: "Shine", website: "http://www.shineboulder.com/", location: "Boulder", dietary_option_list: "gluten free options")
      expect(@restaurant).to be_valid
    end

    it 'validates the presence of the name' do
      @restaurant.name = ""
      expect(@restaurant).to_not be_valid
    end

    it 'validates the presence of the dietary options list' do
      @restaurant.dietary_option_list = nil
      expect(@restaurant).to_not be_valid
    end

    it 'validates the uniqueness of the restaurant name' do
      create_restaurant
      duplicate_restaurant = Restaurant.new(name: "Linger", location: "Highlands, Denver", dietary_option_list: "gluten free options")
      expect(duplicate_restaurant).to_not be_valid
    end
  end

  describe 'search method' do
    it 'searching without dietary options returns restaurants for that location' do
      create_restaurant
      Restaurant.create!(name: 'Japango', location: 'Pearl Street, Boulder', dietary_option_list: "organic ingredients")
      results = Restaurant.search('Highlands, Denver', {})
      expect(results.first.name).to eq 'Linger'
      expect(results.length).to eq 1
    end

    it 'searching with dietary options returns matching restaurants' do
      create_restaurant
      Restaurant.create!(name: 'Root Down', location: 'Highlands, Denver', dietary_option_list: "organic ingredients")
      results = Restaurant.search('Highlands, Denver', 'organic ingredients')
      expect(results.first.name).to eq 'Root Down'
      expect(results.length).to eq 1
    end
  end
end

