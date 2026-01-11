# frozen_string_literal: true

class PlayerTargetFactory

  def self.get_random_player_target
    stats_client = StatsClient.new
    random_team_id = Team.pluck(:stats_api_id).sample
    team_data = stats_client.get_team(random_team_id)
    roster_player_ids = team_data[:roster].map { |player| player[:person][:id] }
    random_player_id = roster_player_ids.sample
    player = PlayerTarget.find_by(stats_api_id: random_player_id.to_s)
    return player if player.present?

    player_data = stats_client.get_player(random_player_id)[:people][0]

    create_from_stats_api_data(player_data)
  end

  def self.get_player_target_by_name(name)
    stats_client = StatsClient.new
    search_result = stats_client.search_players_by_name(name)
    return nil if search_result[:people].blank?

    player_data = search_result[:people][0]
    create_from_stats_api_data(player_data)
  end

  def self.create_from_stats_api_data(data)
    player_target = PlayerTarget.find_or_initialize_by(stats_api_id: data[:id])
    player_target.first_name = data[:firstName]
    player_target.last_name = data[:lastName]
    player_target.jersey_number = data[:primaryNumber]
    player_target.position = data[:primaryPosition][:abbreviation]
    player_target.team_name = data[:currentTeam][:name]
    player_target.batting_hand = data[:batSide][:description]
    player_target.throwing_hand = data[:pitchHand][:description]
    player_target.league = 'NL'

    player_target.save
    player_target
  end

end