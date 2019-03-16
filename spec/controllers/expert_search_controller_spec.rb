require 'rails_helper'

describe ExpertSearchController do
  describe '#index' do
    let!(:users) { create_list(:user, 5) }
    let!(:friendship1) { create :friend, user_id: users[0].id, friend_id: users[1].id }
    let!(:friendship2) { create :friend, user_id: users[1].id, friend_id: users[0].id }
    let!(:friendship3) { create :friend, user_id: users[0].id, friend_id: users[4].id }
    let!(:friendship4) { create :friend, user_id: users[4].id, friend_id: users[0].id }

    let!(:friendship5) { create :friend, user_id: users[3].id, friend_id: users[2].id }
    let!(:friendship6) { create :friend, user_id: users[2].id, friend_id: users[3].id }
    let!(:friendship7) { create :friend, user_id: users[1].id, friend_id: users[3].id }
    let!(:friendship8) { create :friend, user_id: users[3].id, friend_id: users[1].id }

    let!(:userdatum01) { create :userdatum, user_id: users[1].id, data_type: 'heading', data: 'boring hobby 1' }
    let!(:userdatum02) { create :userdatum, user_id: users[1].id, data_type: 'heading', data: 'boring hobby 2' }
    let!(:userdatum03) { create :userdatum, user_id: users[1].id, data_type: 'heading', data: 'boring hobby 3' }
    let!(:userdatum04) { create :userdatum, user_id: users[2].id, data_type: 'heading', data: 'boring hobby 1' }
    let!(:userdatum05) { create :userdatum, user_id: users[2].id, data_type: 'heading', data: 'boring hobby 2' }
    let!(:userdatum06) { create :userdatum, user_id: users[2].id, data_type: 'heading', data: 'cool thing i want for her' }
    let!(:userdatum07) { create :userdatum, user_id: users[3].id, data_type: 'heading', data: 'boring hobby 1' }
    let!(:userdatum08) { create :userdatum, user_id: users[3].id, data_type: 'heading', data: 'boring hobby 2' }
    let!(:userdatum09) { create :userdatum, user_id: users[3].id, data_type: 'heading', data: 'boring hobby 3' }
    let!(:userdatum10) { create :userdatum, user_id: users[3].id, data_type: 'heading', data: 'boring hobby 4' }
    let!(:userdatum11) { create :userdatum, user_id: users[0].id, data_type: 'heading', data: 'boring hobby 1' }
    let!(:userdatum12) { create :userdatum, user_id: users[0].id, data_type: 'heading', data: 'boring hobby 2' }
    let!(:userdatum13) { create :userdatum, user_id: users[0].id, data_type: 'heading', data: 'boring hobby 3' }

    subject { get :index, params: {user_id: users[0].id, terms: ['cool', 'thing', 'i', 'her', 'want']} }
    it 'should return success' do
      subject
      expect(response).to have_http_status(:ok)
    end
    it 'should return proper json' do
      subject
      expect(json_data['attributes']).to eq({
        "result" => "#{users[0].first_name} #{users[0].last_name} -> #{users[1].first_name} #{users[1].last_name} -> #{users[3].first_name} #{users[3].last_name} -> #{users[2].first_name} #{users[2].last_name} -> (cool thing i want for her)",
        "terms" => ['cool', 'thing', 'i', 'her', 'want'],
        "friend_id" => 8,
      })
    end
    it 'should return proper json even when theres no match' do
      get :index, params: {user_id: users[0].id, terms: ['nothing', 'matches']}
      expect(json_data['attributes']).to eq({
          "result" => "No search result found for given terms",
          "terms" => ['nothing', 'matches'],
      })
    end
    it 'should not match if already friends' do
      create :friend, user_id: users[0].id, friend_id: users[2].id
      create :friend, user_id: users[2].id, friend_id: users[0].id
      subject
      expect(json_data['attributes']).to eq({
          "result" => "No search result found for given terms",
          "terms" => ['cool', 'thing', 'i', 'her', 'want'],
      })
    end
  end
end