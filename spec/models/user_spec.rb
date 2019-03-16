require 'rails_helper'

describe User, type: :model do
  describe '#validations' do
    it 'should test the factory is valid' do
      expect(build :user).to be_valid
    end
    it 'should not allow an empty first name' do
      user = build :user, first_name: ''
      expect(user).to_not be_valid
      expect(user.errors.messages[:first_name]).to include("can't be blank")
    end
    it 'should not allow an empty last name' do
      user = build :user, last_name: ''
      expect(user).to_not be_valid
      expect(user.errors.messages[:last_name]).to include("can't be blank")
    end
    it 'should not allow an empty website' do
      user = build :user, website: ''
      expect(user).to_not be_valid
      expect(user.errors.messages[:website]).to include("can't be blank")
    end
    it 'should not allow an invalid url for website' do
      user = build :user, website: 'this.is.not.valid'
      expect(user).to_not be_valid
      expect(user.errors.messages[:website]).to include("is not a valid URL")
    end
  end
end
