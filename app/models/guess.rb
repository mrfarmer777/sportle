class Guess < ApplicationRecord
  belongs_to :game
  belongs_to :player_target, foreign_key: 'target_id', optional: true

  validates :first_name, :last_name, :game_id, presence: true

  after_create :check_guess

  private

  def check_guess
    return unless player_target.present?

    game_target = game.player_target
    if player_target.stats_api_id == game_target.stats_api_id
      game.update(found_player: true, found_position: true, found_team: true,
                  found_throwing_hand: true, found_batting_hand: true,
                  found_league: true, found_jersey_number: true,
                  status: 'completed')
    else
      if player_target.position == game_target.position
        game.update(found_position: true)
      end
      if player_target.team_name == game_target.team_name
        game.update(found_team: true)
      end
      if player_target.throwing_hand == game_target.throwing_hand
        game.update(found_throwing_hand: true)
      end
      if player_target.batting_hand == game_target.batting_hand
        game.update(found_batting_hand: true)
      end
      if player_target.league == game_target.league
        game.update(found_league: true)
      end
      if player_target.jersey_number == game_target.jersey_number
        game.update(found_jersey_number: true)
      end
    end
  end
end
