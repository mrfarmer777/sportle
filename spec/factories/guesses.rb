FactoryBot.define do
  factory :guess do
    game { create :game }
    first_name { 'Barry' }
    last_name { 'Bonds' }
    target_id { nil }
  end
end
