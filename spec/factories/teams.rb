FactoryBot.define do
  factory :team do
    name { "#{Faker::Address.city} #{Faker::Sports::Football.team}" }
    sequence(:stats_api_id) { |n| n }
    abbreviation { name.split.map(&:first).join[0..3].upcase }
  end
end