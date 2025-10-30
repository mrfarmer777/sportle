FactoryBot.define do
  factory :game do
    player_target_id { create(:player_target).id }
    total_guesses { 0 }
    status { 'started' }
    found_player  { false }
    found_team    { false }
    found_position { false }
    found_jersey_number { false }
    found_throwing_hand { false }
    found_batting_hand  { false }
    found_league        { false }
  end
end
