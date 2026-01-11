require 'rails_helper'

RSpec.describe 'Game Show Page', type: :system do
  let(:page_path) { game_path(id: game.id) }
  let!(:team) { create(:team) }
  let(:player_target) { create(:player_target, team_name: 'Los Angeles Dodgers', position: 'TWP') }
  let!(:game) { create(:game, player_target:) }
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

  before(:each) do
    allow_any_instance_of(StatsClient).to receive(:search_players_by_name).and_return({people: [player_data]})
  end


  it 'displays the game info' do
    visit page_path

    expect(page).to have_content(game.status)
    expect(page).to have_content(game.total_guesses)
    expect(page).to have_content("Found player: false")
  end

  it 'allows the player to make a guess' do
    visit page_path

    fill_in 'name', with: "Shohei Ohtani"
    click_button 'Submit Guess'

    game.reload
    expect(game.guesses.count).to eq(1)
    expect(page).to have_content('Shohei Ohtani')
  end

  it 'updates game status after a guess is made' do
    visit page_path

    fill_in 'name', with: "Shohei Ohtani"
    click_button 'Submit Guess'

    expect(page).to have_content('Found team: true')
    expect(page).to have_content('Found position: true')
    expect(page).to have_content('Found throwing hand: true')
    expect(page).to have_content('Found batting hand: false')
  end

  it 'updates game to completed when player is guessed correctly' do
    player_data[:id] = player_target.stats_api_id
    visit page_path

    fill_in 'name', with: "Shohei Ohtani"
    click_button 'Submit Guess'

    expect(page).to have_content('Status: completed')
    game.reload
    expect(game.status).to eq('completed')
    expect(game.found_player).to be true
  end
end
