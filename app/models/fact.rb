class Fact < ActiveRecord::Base
  acts_as_votable

  #def self.default_scope
  #  self.order
  #end

  belongs_to :restaurant
  belongs_to :user
end