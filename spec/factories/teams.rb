FactoryBot.define do
  factory :team do
    name { "#{Faker::Address.city} #{Faker::Sports::Football.team}" }
    sequence(:stats_api_id) { |n| n }
  end
end