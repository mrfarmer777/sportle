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

  def self.create_from_stats_api_data(data)
    player_target = PlayerTarget.new(
      stats_api_id: data[:id],
      first_name: data[:firstName],
      last_name: data[:lastName],
      jersey_number: data[:primaryNumber],
      position: data[:primaryPosition][:abbreviation],
      team_name: data[:currentTeam][:name],
      batting_hand: data[:batSide][:description],
      throwing_hand: data[:pitchHand][:description],
      league: 'NL'
    )

    player_target.save
    player_target
  end

end