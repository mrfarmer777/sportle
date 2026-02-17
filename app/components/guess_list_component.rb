# frozen_string_literal: true

class GuessListComponent < ViewComponent::Base

  attr_reader :guesses, :player_target

  COLUMN_SIZE_CLASSES = {
    player_name: 'guess-line__data--player-name',
    jersey_number: 'guess-line__data--medium',
    league: 'guess-line__data--medium',
    team_name: nil,
    position: 'guess-line__data--medium',
    batting_hand: 'guess-line__data--medium',
    throwing_hand: 'guess-line__data--medium'
  }.freeze

  def initialize(guesses:, player_target:)
    @guesses = guesses
    @player_target = player_target
  end

  def call
    render_header + safe_join(render_guesses)
  end

  private

  def render_header
    tag.div(class: 'guess-line game-guesses__header') do
      concat render_guess_line_data('Player Name', 'guess-line__player-name')
      concat render_guess_line_data('#', 'guess-line__data--medium')
      concat render_guess_line_data('Lg.', 'guess-line__data--medium')
      concat render_guess_line_data('Tm.')
      concat render_guess_line_data('Pos.', 'guess-line__data--medium')
      concat render_guess_line_data('BH', 'guess-line__data--medium')
      concat render_guess_line_data('TH.', 'guess-line__data--medium')
    end
  end

  def render_guesses
    (0..9).map do |index|
      guess = guesses[index]
      render_guess_line(guess)
    end
  end

  def render_guess_line(guess)
    tag.div(class: 'guess-line') do
      render_name_data(guess)
      concat render_jersey_number_data(guess)
      concat render_league_data(guess)
      concat render_team_data(guess)
      concat render_position_data(guess)
      concat render_batting_hand_data(guess)
      concat render_throwing_hand_data(guess)
    end
  end

  def render_name_data(guess)
    classes = ['guess-line__player-name guess-line__data']
    classes << 'guess-line__data--matched' if guess&.player_target&.stats_api_id == player_target.stats_api_id
    first_name = guess&.player_target&.first_name || ""
    last_name = guess&.player_target&.last_name || ""
    concat render_guess_line_data("#{first_name} #{last_name}".strip, classes)
  end

  def render_jersey_number_data(guess)
    classes = ['guess-line__data--medium']
    classes << 'guess-line__data--matched' if guess&.player_target&.jersey_number == player_target.jersey_number
    render_guess_line_data(guess&.player_target&.jersey_number, classes)
  end

  def render_league_data(guess)
    classes = ['guess-line__data--medium']
    classes << 'guess-line__data--matched' if guess&.player_target&.league == player_target.league
    render_guess_line_data(guess&.player_target&.league, classes)
  end

  def render_team_data(guess)
    classes = []
    classes << 'guess-line__data--matched' if guess&.player_target&.team_name == player_target.team_name
    team_name = guess&.player_target&.team_name
    abbreviation = team_name ? Team.find_by(name: team_name)&.abbreviation : nil
    render_guess_line_data(abbreviation, classes)
  end

  def render_position_data(guess)
    classes = ['guess-line__data--medium']
    classes << 'guess-line__data--matched' if guess&.player_target&.position == player_target.position
    render_guess_line_data(guess&.player_target&.position, classes)
  end

  def render_batting_hand_data(guess)
    classes = ['guess-line__data--medium']
    classes << 'guess-line__data--matched' if guess&.player_target&.batting_hand == player_target.batting_hand
    batting_hand = guess&.player_target&.batting_hand&.[](0)
    render_guess_line_data(batting_hand, classes)
  end

  def render_throwing_hand_data(guess)
    classes = ['guess-line__data--medium']
    classes << 'guess-line__data--matched' if guess&.player_target&.throwing_hand == player_target.throwing_hand
    throwing_hand = guess&.player_target&.throwing_hand&.[](0)
    render_guess_line_data(throwing_hand, classes)
  end

  def render_guess_line_data(data, additional_classes = nil)
    tag.div(data, class: class_names('guess-line__data', additional_classes))
  end
end

