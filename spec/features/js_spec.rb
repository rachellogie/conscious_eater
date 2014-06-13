require 'spec_helper'
require 'requests/rails_helper'

feature 'JS interactions' do

  scenario 'stuff', js: true do
    visit restaurants_path
    expect(page).to have_css('#map_canvas')

    # get a help link from the map canvas that contains the latitude and longitude
    mapCoordinateString = page.first('#map_canvas').first('a')['href']

    targetCoordinates = Rack::Utils.parse_query URI(mapCoordinateString).query
    splitString = targetCoordinates['ll'].split(',')

    # check loaded coordinates
    expect(splitString[0].to_f).to be_within(0.1).of(40)
    expect(splitString[1].to_f).to be_within(0.1).of(-105.2)
  end
end