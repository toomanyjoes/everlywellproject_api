require 'rails_helper'

describe 'userdata routes' do
  it 'should route to userdata index' do
    expect(get '/users/1/userdata').to route_to('userdata#index', user_id: '1')
  end
  it 'should route to userdata create' do
    expect(post '/users/1/userdata').to route_to('userdata#create', user_id: '1')
  end
  it 'should route to user friends destroy' do
    expect(delete '/users/1/userdata/1').to route_to('userdata#destroy', user_id: '1', id: '1')
  end
end