FactoryBot.define do
  factory :game do
    player_target_id { create(:player_target).id }
    result { nil }
    total_guesses { 0 }
    status { 'started' }
  end
end
