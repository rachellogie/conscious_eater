class User < ActiveRecord::Base


  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restaurants, through: :favorite_restaurants
  has_many :favorite_restaurants, dependent: :destroy
  has_many :preferences

  has_many :facts
end
