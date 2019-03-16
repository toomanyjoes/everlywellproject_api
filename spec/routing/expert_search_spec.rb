require 'rails_helper'

describe 'expert search routes' do
  it 'should route to expert search index' do
    expect(get '/users/1/expert_search').to route_to('expert_search#index', user_id: '1')
  end
end