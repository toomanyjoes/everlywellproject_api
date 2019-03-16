FactoryBot.define do
  factory :userdatum do
    sequence(:user_id) { |n| n }
    data_type { "heading" }
    sequence(:data) { |n| "My expert heading #{n}" }
  end
end
