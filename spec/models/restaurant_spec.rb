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

  end
end

