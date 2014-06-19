require 'spec_helper'


describe 'Likes' do

  it 'can upvote and downvote a fact through likes' do
    user = User.create!(email: 'bob@bob.com', password: 'password')
    restaurant = create_restaurant
    fact = Fact.create(body: "Really cool", restaurant_id: restaurant.id, user_id: user.id)
    expect(fact.get_likes.size).to eq 0
    fact.liked_by user
    fact.liked_by user
    expect(fact.get_likes.size).to eq 1
    user2 = User.create!(email: 'fsdagrawgrw@bob.com', password: 'password')
    fact.liked_by user2
    expect(fact.get_likes.size).to eq 2
    fact.downvote_from user
    expect(fact.get_likes.size).to eq 1
  end

end