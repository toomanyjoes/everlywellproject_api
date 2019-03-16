FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name) { |n| "Doe#{n}" }
    sequence(:website) { |n| "http://bit.ly/#{n}" }
  end
end
