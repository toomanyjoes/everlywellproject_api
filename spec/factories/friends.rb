FactoryBot.define do
  factory :friend do
    sequence(:user_id) { |n| n }
    sequence(:friend_id) { |n| n+1 }
  end
end
