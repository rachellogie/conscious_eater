require 'spec_helper'


#do I even need this test at all??


describe 'Likes' do

  it 'can upvote and downvote a fact through likes' do
    user = create_user('bob@bob.com')
    restaurant = create_restaurant
    fact = Fact.create(body: "Really cool", restaurant_id: restaurant.id, user_id: user.id)
    expect(fact.get_likes.size).to eq 0
    fact.liked_by user
    fact.liked_by user
    expect(fact.get_likes.size).to eq 1
    user2 = create_user('fsdagrawgrw@bob.com')
    fact.liked_by user2
    expect(fact.get_likes.size).to eq 2
    fact.downvote_from user
    expect(fact.get_likes.size).to eq 1
  end

end