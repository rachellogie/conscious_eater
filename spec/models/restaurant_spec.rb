require 'spec_helper'

describe Restaurant do

  it 'validates the presence of the name' do
    pending
    restaurant = Restaurant.create!(name: "Shine", location:"Boulder", dietary_option_list:"gluten free")

    restaurant.name = ""

    expect(restaurant).to_not be_valid
  end

end
