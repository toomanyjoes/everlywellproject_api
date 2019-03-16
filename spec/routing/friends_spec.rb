require 'rails_helper'

describe 'friends routes' do
  it 'should route to user\'s friends index' do
    expect(get '/users/1/friends').to route_to('friends#index', user_id: '1')
  end
  it 'should route to friends create' do
    expect(post '/users/1/friends').to route_to('friends#create', user_id: '1')
  end
  it 'should route to user friends destroy' do
    expect(delete '/users/1/friends/1').to route_to('friends#destroy', user_id: '1', id: '1')
  end
end