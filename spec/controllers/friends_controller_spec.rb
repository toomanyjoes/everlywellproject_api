require 'rails_helper'

describe FriendsController do
  describe '#index' do
    let!(:users) { create_list(:user, 4) }
    let!(:friendship1) { create :friend, user_id: users[0].id, friend_id: users[1].id }
    let!(:friendship2) { create :friend, user_id: users[1].id, friend_id: users[0].id }
    let!(:friendship3) { create :friend, user_id: users[0].id, friend_id: users[2].id }
    let!(:friendship4) { create :friend, user_id: users[2].id, friend_id: users[0].id }
    let!(:friendship5) { create :friend, user_id: users[0].id, friend_id: users[3].id }
    let!(:friendship6) { create :friend, user_id: users[3].id, friend_id: users[0].id }
    subject { get :index, params: {user_id: users[0].id} }
    it 'should return success' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      friendships = [friendship1, friendship3, friendship5]
      subject
      friendships.each_with_index do |friendship, index|
        expect(json_data[index]['attributes']).to eq({
          "user_id" => friendship.user_id,
          "friend_id" => friendship.friend_id,
        })
      end
    end
  end

  describe '#create' do
    context 'when invalid parameters are provided' do
      let!(:user) { create :user }
      let!(:invalid_attributes) do
        {
            'user_id': user.id,
            'data': {
                'attributes': {
                    'friend_id': '',
                }
            }
        }
      end
      subject { post :create, params: invalid_attributes}

      it 'should return a 422 status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return proper error json' do
        subject
        expect(json['errors']).to include(
          {"detail"=>"can't be blank", "source"=>{"pointer"=>"/data/attributes/friend_id"}},
        )
      end
    end

    context 'when a friendship is created successfully' do
      let!(:user) { create :user }
      let!(:friend) { create :user }
      let!(:valid_attributes) do
        {
            'user_id': user.id,
            'data': {
                'attributes': {
                    'friend_id': friend.id
                }
            }
        }
      end
      subject { post :create, params: valid_attributes}

      it 'should return a 201 created status code' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'should have expected json_api formatted body' do
        subject
        expected = {
            'data': [{
                'attributes': {
                    'user_id': user.id,
                    'friend_id': friend.id
                }
            },{
                'attributes': {
                    'user_id': friend.id,
                    'friend_id': user.id
                }
            }]
        }
        expected.each_with_index do |_ , index|
          expect(json_data[index]).to include(expected[:data][index].with_indifferent_access) # with_indifferent_access because keys are getting converted from strings to symbols, this converts them back
        end
      end

      it 'should create the friendship' do
        expect{ subject }.to change{ Friend.count }.by(2) # Bidirectional friendship will create 2 entries
      end
    end
  end

  describe "#destroy" do
    let!(:user) { create :user }
    let!(:friend) { create :user }
    let!(:friendship) { create :friend, user_id: user.id, friend_id: friend.id }
    let!(:inverse_friendship) { create :friend, user_id: friend.id, friend_id: user.id }
    subject { delete :destroy, params: { id: friendship.id, user_id: user.id} }

    it 'should return status no content' do
      subject
      expect(response).to have_http_status(:no_content)
    end
    it 'should delete the friendships' do
      expect{ subject }.to change{ Friend.count }.by(-2) # Bidirectional friendship means remove 2 entries
    end
  end
end