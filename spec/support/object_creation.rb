module ObjectCreation

  def create_restaurant
    VCR.use_cassette('objectcreation/create_restaurant') do
      Restaurant.create!(name: "Linger", location: "Highlands, Denver", dietary_option_list: "gluten free options")
    end
  end
end