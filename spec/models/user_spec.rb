require 'spec_helper'

describe User do
  it 'should respond to restaurants' do
    user = User.create!(email: 'foo@example.com', password: 'password',password_confirmation: 'password')
    expect(user).to respond_to(:restaurants)
  end
end
