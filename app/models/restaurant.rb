class Restaurant < ActiveRecord::Base

  DIETARY_OPTIONS = ["vegan", "dairy free", "vegetarian option", "gluten free", "organic", "non-GMO"]
  acts_as_taggable_on :dietary_options

  validates :name, presence: true
  validates :dietary_option_list, presence: {message: "You must check at least 1 diet option"}

end
