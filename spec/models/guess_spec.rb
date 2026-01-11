require 'rails_helper'

RSpec.describe Guess, type: :model do
  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:game_id) }
  end

  context 'associations' do
    it { should belong_to(:game) }
    it { should belong_to(:player_target).optional }
  end

  context 'creating new guesses' do
    let(:player_target) { create(:player_target, first_name: 'John', last_name: 'Doe', jersey_number: 2) }
    let(:guess_target) { create(:player_target, first_name: 'Joe', last_name: 'Smith', jersey_number: 2) }

    it 'updates game state when jersey number is guessed' do
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_jersey_number).to be true
    end

    it 'updates game state when position is guessed' do
      player_target.update(position: 'Pitcher')
      guess_target.update(position: 'Pitcher')
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_position).to be true
    end

    it 'updates game state when team is guessed' do
      player_target.update(team_name: 'Yankees')
      guess_target.update(team_name: 'Yankees')
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_team).to be true
    end

    it 'updates game state when throwing hand is guessed' do
      player_target.update(throwing_hand: 'R')
      guess_target.update(throwing_hand: 'R')
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_throwing_hand).to be true
    end

    it 'updates game state when batting hand is guessed' do
      player_target.update(batting_hand: 'L')
      guess_target.update(batting_hand: 'L')
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_batting_hand).to be true
    end

    it 'updates game state when league is guessed' do
      player_target.update(league: 'AL')
      guess_target.update(league: 'AL')
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_league).to be true
    end

    it 'updates game state when multiple attributes are guessed correctly' do
      player_target.update(position: 'Catcher', team_name: 'Mets', jersey_number: 5)
      guess_target.update(position: 'Catcher', team_name: 'Mets', jersey_number: 5)
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: guess_target.id, first_name: 'Joe', last_name: 'Smith')
      game.reload

      expect(game.found_position).to be true
      expect(game.found_team).to be true
      expect(game.found_jersey_number).to be true
    end

    it 'does not update game state when no part of the guess is correct' do
      player_target = create(:player_target, first_name: 'John', last_name: 'Doe', jersey_number: 3)
      game = create(:game, player_target: player_target)
      create(:guess, game: game, first_name: 'Alice', last_name: 'Johnson')
      game.reload

      expect(game.found_jersey_number).to be false
    end

    it 'updates game state when the guess matches the player target completely' do
      game = create(:game, player_target: player_target)
      create(:guess, game: game, target_id: player_target.id, first_name: 'John', last_name: 'Doe')
      game.reload

      expect(game.found_player).to be true
      expect(game.found_jersey_number).to be true
      expect(game.found_position).to be true
      expect(game.found_team).to be true
      expect(game.found_throwing_hand).to be true
      expect(game.found_batting_hand).to be true
      expect(game.found_league).to be true
    end
  end
end
