require 'rails_helper'

describe 'user routes' do
  it 'should route to users index' do
    expect(get '/users/').to route_to('users#index')
  end
  it 'should route to users show' do
    expect(get '/users/1').to route_to('users#show', id: '1')
  end
  it 'should route to users create' do
    expect(post '/users/').to route_to('users#create')
  end
end