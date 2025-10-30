FactoryBot.define do
  factory :player_target do
    first_name { "Willy" }
    last_name  { "Adames" }
    position   { "SS" }
    team_name  { "Milwaukee Brewers" }
    jersey_number { "2" }
    throwing_hand { "Right" }
    batting_hand  { "Switch" }
    league        { "NL" }
    stats_api_id  { "642715" }
  end
end
