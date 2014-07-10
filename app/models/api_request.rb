require 'faraday'

class APIRequest

  def initialize(key = ENV['GOOGLE_API_KEY'])
    @key = key
    @api_root = "https://maps.googleapis.com/maps/api/"
  end

  def neighborhoods
    {"Pearl Street, Boulder" => "1942 Broadway St, Boulder, CO 80302", "Highlands, Denver" => "2030 W. 30th Ave., Denver, CO 80211"}
  end

  def get_lat_lng(location)
    address = neighborhoods[location]
    response = Faraday.get "#{@api_root}geocode/json?address=#{address}{&sensor=false&key=#{@key}"
    coordinates = JSON.parse(response.body)["results"].first["geometry"]["location"]
    return coordinates["lat"], coordinates["lng"]
  end

  def get_first_result(restaurant_name, location)
    latitude, longitude =  get_lat_lng(location)

    response = Faraday.get "#{@api_root}place/nearbysearch/json?location=#{latitude},#{longitude}&radius=1000&types=food&name=#{restaurant_name}&sensor=false&key=#{@key}"
    first_match = JSON.parse(response.body)["results"].first

    if first_match.nil?
      return ApiResponse.new(nil)
    end

    my_response = ApiResponse.new(first_match)

    response = get_photo(my_response.photo_reference)
    my_response.add_photo(response)

    response = get_website(my_response.place_reference)
    my_response.add_website(response)
    my_response
  end

  def get_photo(photo_reference)
    response = Faraday.get "#{@api_root}place/photo?maxwidth=400&photoreference=#{photo_reference}&sensor=false&key=#{@key}"
    response.body
  end

  def get_website(place_reference)
    response = Faraday.get "#{@api_root}place/details/json?reference=#{place_reference}&sensor=true&key=#{@key}"
    JSON.parse(response.body)
  end

end