module RestaurantsHelper

  def fact_user_name(fact)
    user = User.find(fact.user_id).email
    #get just the first part without the domain name
    user[0...(user.index('@'))]
  end

end