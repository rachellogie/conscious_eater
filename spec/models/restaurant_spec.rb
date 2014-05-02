require 'spec_helper'

describe Restaurant do

  it 'validates the presence of the name' do
    restaurant = Restaurant.create!(name: "Shine", location:"Boulder", dietary_option_list:"gluten free")
    restaurant.name = ""
    expect(restaurant).to_not be_valid
  end

  it 'validates the presence of the dietary options list' do
    restaurant = Restaurant.create!(name: "Shine", location:"Boulder", dietary_option_list:"gluten free")
    restaurant.dietary_option_list = nil
    expect(restaurant).to_not be_valid
  end

end
