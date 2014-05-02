class Restaurant < ActiveRecord::Base

  DIETARY_OPTIONS = ["vegan", "dairy free", "vegetarian option", "gluten free", "organic", "non-GMO"]
  acts_as_taggable_on :dietary_options

end
