class Fact < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user
end