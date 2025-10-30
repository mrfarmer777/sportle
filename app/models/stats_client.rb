# frozen_string_literal: true
class StatsClient

  BASE_URL = 'https://statsapi.mlb.com/api/v1'

  attr_reader :conn

  def initialize
    @conn = Faraday.new(BASE_URL) do |builder|
      builder.response :json, parser_options: { symbolize_names: true }
      builder.adapter Faraday.default_adapter
    end
  end

  def get_team(stats_team_id)
    conn.get("teams/#{stats_team_id}/roster").body
  end

  def get_player(stats_player_id)
    conn.get("people/#{stats_player_id}?hydrate=rosterEntries,currentTeam").body
  end
end