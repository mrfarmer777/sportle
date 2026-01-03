require 'rails_helper'

RSpec.describe 'Games Page', type: :system do
  let(:page_path) { games_path }
  let!(:team) { create(:team) }
  let!(:games) {
    [
      create(:game),
      create(:game, total_guesses: 1, status: 'started'),
      create(:game, total_guesses: 10, status: 'finished', found_player: true)
    ]
  }

  let(:player_target) { create(:player_target) }

  before(:each) do
    allow(PlayerTargetFactory).to receive(:get_random_player_target).and_return(player_target)
  end


  it 'displays all games' do
    visit page_path

    games.each do |game|
      expect(page).to have_content(game.status)
      expect(page).to have_content(game.total_guesses)
    end
  end

  it 'allows the player to start a new game and redirects to the show page' do
    visit page_path

    click_button 'Start New Game'

    expect(page).to have_content('Guess the player...')
    expect(Game.count).to eq(4)
  end
end
