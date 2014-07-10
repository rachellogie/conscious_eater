class ApiResponse

  attr_accessor :photo, :website

  def initialize(first_match)
    @api_first_response = first_match
  end

  def restaurant_coordinates
    @api_first_response["geometry"]["location"]
  end

  def address
    @api_first_response["vicinity"]
  end

  def rating
    @api_first_response["rating"]
  end

  def name
    @api_first_response["name"]
  end

  def add_photo(response)
    match = response.scan /<A\sHREF.+">/
    if match.first.nil?
      @photo = default_image
    else
      @photo = match.first[9..-3]
    end
  end

  def photo_reference
    unless @api_first_response["photos"].nil?
      @api_first_response["photos"].first["photo_reference"]
    end

  end

  def default_image
    "https://47006bd19c074195238a-b0b757299a8f3a7022a498c3b4069649.ssl.cf2.rackcdn.com/media/photos/3956/large-f3c5d0c3666eec8c.jpg?1369865351"
  end

  def place_reference
    @api_first_response["reference"]
  end

  def add_website(response)
    @website = response["result"]["website"]
  end

  def to_h
    attributes = {}
    if matches?
      attributes_merge = attributes.merge!(
        rating: rating,
        address: address,
        photo_uri: photo,
        website: website,
        name: name,
        latitude: restaurant_coordinates["lat"],
        longitude: restaurant_coordinates["lng"],
      )
      attributes_merge
    end
    attributes
  end

  def matches?
    if @api_first_response.nil?
      false
    else
      true
    end
  end

end