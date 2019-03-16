require 'rails_helper'

describe Userdatum, type: :model do
  describe '#validations' do
    it 'should test for user existence before creating data' do
      data = build :userdatum
      expect(data).to_not be_valid
      expect(data.errors.messages[:user]).to include("must exist")
    end
    it 'should test the factory is valid' do
      create :user, id: 1
      data = build :userdatum, user_id: 1
      expect(data).to be_valid
    end
    it 'should not allow an empty data_type' do
      data = build :userdatum, data_type: ''
      expect(data).to_not be_valid
      expect(data.errors.messages[:data_type]).to include("can't be blank")
    end
  end
end
