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
      puts duplicate_restaurant.errors.full_messages
      expect(duplicate_restaurant).to_not be_valid
    end

  end
end

