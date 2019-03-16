require 'rails_helper'

describe UserdataController do
  describe '#index' do
    let!(:user) { create :user }
    let!(:userdata) { create_list :userdatum, 3, user_id: user.id }
    subject { get :index, params: {user_id: user.id} }
    it 'should return success' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject
      userdata.each_with_index do |data, index|
        expect(json_data[index]['attributes']).to eq({
          "user_id" => data.user_id,
          "data_type" => data.data_type,
          "data" => data.data,
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
                    'data_type': '',
                    'data': '',
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
          {"detail"=>"can't be blank", "source"=>{"pointer"=>"/data/attributes/data_type"}},
          {"detail"=>"can't be blank", "source"=>{"pointer"=>"/data/attributes/data"}},
        )
      end
    end

    context 'when userdata is created successfully' do
      let!(:user) { create :user }
      let!(:valid_attributes) do
        {
            'user_id': user.id,
            'data': {
                'attributes': {
                    'user_id': user.id,
                    'data_type': 'heading',
                    'data': 'My Awesome Skills',
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
            'user_id': user.id,
            'data': {
                'attributes': {
                    'user_id': user.id,
                    'data_type': 'heading',
                    'data': 'My Awesome Skills',
                }
            }
        }
        expect(json_data['attributes']).to include(expected[:data][:attributes].with_indifferent_access)
      end

      it 'should create the user' do
        expect{ subject }.to change{ Userdatum.count }.by(1)
      end
    end
  end
end