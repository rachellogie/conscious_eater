require 'spec_helper'

describe Restaurant do


  before do
    @restaurant = Restaurant.new(name: "Shine", website:"http://www.shineboulder.com/", location:"Boulder", dietary_option_list:"gluten free")
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

  it 'validates url' do
    @restaurant.website = "shine.com"
    expect(@restaurant).to_not be_valid
  end

end
