require 'rails_helper'

describe Friend, type: :model do
  describe '#validations' do
    it 'should test for user existence before creating friend' do
      friend = build :friend
      expect(friend).to_not be_valid
      expect(friend.errors.messages[:user]).to include("must exist")
    end
    it 'should test the factory is valid' do
      create :user, id: 1
      friend = build :friend, user_id: 1, friend_id: 2
      expect(friend).to be_valid
    end
    it 'should not allow an empty friend_id' do
      friend = build :friend, friend_id: ''
      expect(friend).to_not be_valid
      expect(friend.errors.messages[:friend_id]).to include("can't be blank")
    end
    it 'should not allow an identity friendship' do
      friend = build :friend, user_id: 15, friend_id: 15
      expect(friend).to_not be_valid
      expect(friend.errors.messages[:friend_id]).to include("cannot be friends with yourself")
    end
  end
end
