class Fact < ActiveRecord::Base
  acts_as_votable

  belongs_to :restaurant
  belongs_to :user
end