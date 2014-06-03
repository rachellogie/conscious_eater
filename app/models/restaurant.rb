class Restaurant < ActiveRecord::Base

  DIETARY_OPTIONS = [ "gluten free options", "dairy free options", "vegan options", "vegetarian options",
                     "organic ingredients", "grass fed beef", "100% gluten free",
                     "100% vegetarian", "100% vegan",]

  acts_as_taggable_on :dietary_options

  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :location}
  validates :dietary_option_list, presence: {message: "You must check at least 1 diet option"}

  has_many :favorite_restaurants
  has_many :users, through: :favorite_restaurants

  has_many :facts

  def facts
    facts = super
    facts.sort { |a,b| b.get_likes.size <=> a.get_likes.size }
  end

end
