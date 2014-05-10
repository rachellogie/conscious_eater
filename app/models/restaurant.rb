class Restaurant < ActiveRecord::Base

  DIETARY_OPTIONS = [ "gluten free options", "dairy free options", "vegan options", "vegetarian options",
                     "organic ingredients", "non-GMO ingredients", "grass-fed beef", "100% gluten free",
                     "100% vegetarian", "100% vegan",]
  acts_as_taggable_on :dietary_options

  validates :name, presence: true
  validates :dietary_option_list, presence: {message: "You must check at least 1 diet option"}
  validates :website, :format => { :with => URI::regexp(%w(http https)), :message => ": Please enter a valid url"}

  after_create :add_metadata

  def add_metadata
    search = PlacesSearch.new(ENV["GOOGLE_API_KEY"], self.name, self.location)
    if search.matches?
      self.rating = search.get_rating
      self.address = search.get_address
      self.photo_uri = search.get_photo[9..-3]
      self.website = search.get_website
      self.name = search.get_name
      self.save
    end
  end
end
