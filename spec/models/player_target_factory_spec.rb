# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayerTargetFactory, type: :model do
  let(:player_data) do
    {
      "id": 660271,
      "firstName": "Shohei",
      "lastName": "Ohtani",
      "primaryNumber": "17",
      "currentTeam": {
        "id": 119,
        "name": "Los Angeles Dodgers",
        "link": "/api/v1/teams/119"
      },
      "primaryPosition": {
        "code": "Y",
        "name": "Two-Way Player",
        "type": "Two-Way Player",
        "abbreviation": "TWP"
      },
      "batSide": {
        "code": "L",
        "description": "Left"
      },
      "pitchHand": {
        "code": "R",
        "description": "Right"
      },
    }.deep_symbolize_keys!
  end

  describe '.get_random_player_target' do
    let(:team_data) do
      {
        "copyright": "Copyright 2025 MLB Advanced Media, L.P.  Use of any content on this page acknowledges agreement to the terms posted here http://gdx.mlb.com/components/copyright.txt",
        "roster": [
          {
            "person": {
              "id": 642715,
              "fullName": "Willy Adames",
              "link": "/api/v1/people/642715"
            },
            "jerseyNumber": "2",
            "position": {
              "code": "6",
              "name": "Shortstop",
              "type": "Infielder",
              "abbreviation": "SS"
            },
            "status": {
              "code": "A",
              "description": "Active"
            },
            "parentTeamId": 137
          },
          {
            "person": {
              "id": 527038,
              "fullName": "Wilmer Flores",
              "link": "/api/v1/people/527038"
            },
            "jerseyNumber": "41",
            "position": {
              "code": "3",
              "name": "First Base",
              "type": "Infielder",
              "abbreviation": "1B"
            },
            "status": {
              "code": "A",
              "description": "Active"
            },
            "parentTeamId": 137
          }
        ],
        "link": "/api/v1/teams/137/roster",
        "teamId": 137,
        "rosterType": "active"
      }.deep_symbolize_keys!
    end

    before(:each) do
      allow_any_instance_of(StatsClient).to receive(:get_team).and_return(team_data)
      allow_any_instance_of(StatsClient).to receive(:get_player).and_return({people: [player_data]})
    end


    it 'returns a player_target from a randomly-chosen player' do
      player_target = PlayerTargetFactory.get_random_player_target

      expect(player_target).to be_a(PlayerTarget)
      expect(player_target).to be_persisted
    end

    context 'when a randomly chosen player_target already exists' do
      it 'returns the existing player_target instead of creating a duplicate' do
        expect_any_instance_of(StatsClient).not_to receive(:get_player)
        existing_player_target_1 = FactoryBot.create(:player_target, stats_api_id: '642715')
        existing_player_target_2 = FactoryBot.create(:player_target, stats_api_id: '527038')

        player_target = PlayerTargetFactory.get_random_player_target

        expect([existing_player_target_1, existing_player_target_2]).to include(player_target)
      end
    end
  end

  describe '.create_from_stats_api_data' do
    it 'creates a PlayerTarget from given stats API data' do
      player_target = PlayerTargetFactory.create_from_stats_api_data(player_data)

      expect(player_target.stats_api_id).to eq('660271')
      expect(player_target.first_name).to eq('Shohei')
      expect(player_target.last_name).to eq('Ohtani')
      expect(player_target.position).to eq('TWP')
      expect(player_target.team_name).to eq('Los Angeles Dodgers')
      expect(player_target.jersey_number).to eq('17')
      expect(player_target.throwing_hand).to eq('Right')
      expect(player_target.batting_hand).to eq('Left')
      expect(player_target.league).to eq('NL')
      expect(player_target).to be_persisted
    end
  end
end