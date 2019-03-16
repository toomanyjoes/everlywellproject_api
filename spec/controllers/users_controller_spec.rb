require 'rails_helper'

describe UsersController do
  describe '#index' do
    subject { get :index }
    it 'should return success' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      users = create_list :user, 3
      subject
      users.each_with_index do |user, index|
        expect(json_data[index]['attributes']).to eq({
          "first_name" => user.first_name,
          "last_name" => user.last_name,
          "website" => user.website,
        })
      end
    end
  end

  describe '#show' do
    let(:user) { create :user }
    subject { get :show, params: { id: user.id } }

    it 'should return success' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject
      expect(json_data['attributes']).to eq({
        "first_name" => user.first_name,
        "last_name" => user.last_name,
        "website" => user.website,
      })
    end
  end

  describe '#create' do
    context 'when invalid parameters are provided' do
      let!(:invalid_attributes) do
        {
            'data': {
                'attributes': {
                    'first_name': '',
                    'last_name': '',
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
          {"detail"=>"can't be blank", "source"=>{"pointer"=>"/data/attributes/first_name"}},
          {"detail"=>"can't be blank", "source"=>{"pointer"=>"/data/attributes/last_name"}},
          {"detail"=>"can't be blank", "source"=>{"pointer"=>"/data/attributes/website"}},
        )
      end
    end

    context 'when a user is created successfully' do
      let!(:valid_attributes) do
        {
            'data': {
                'attributes': {
                    'first_name': 'Natalia',
                    'last_name': 'Stanton',
                    'website': 'https://www.bogusurl.com',
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
            'data': {
                'attributes': {
                    'first_name': 'Natalia',
                    'last_name': 'Stanton',
                    'website': 'http://bit.ly/2FbQ4iW',
                }
            }
        }
        expect(json_data['attributes']).to include(expected[:data][:attributes].with_indifferent_access)
      end

      it 'should create the user' do
        expect{ subject }.to change{ User.count }.by(1)
      end

      it 'should create the user data' do
        expect{ subject }.to change{ Userdatum.count }.by(3) # There are 3 headings in our mock in spec_helper.rb
      end
    end
  end
end