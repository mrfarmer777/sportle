# frozen_string_literal: true

require 'rails_helper'

describe 'StatsAPIClient', type: :model do

  describe '#get_team' do
    it 'calls the team API endpoint with the given team id' do
      stub = stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/123/roster")

      StatsClient.new.get_team(123)
      expect(stub).to have_been_requested
    end
  end

  describe '#get_player' do
    it 'calls the player API endpoint with the given player id with roster entry hydration' do
      stub = stub_request(:get, "https://statsapi.mlb.com/api/v1/people/456?hydrate=rosterEntries,currentTeam")

      StatsClient.new.get_player(456)
      expect(stub).to have_been_requested
    end
  end
end