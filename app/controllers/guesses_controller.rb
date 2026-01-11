class GuessesController < ApplicationController

  def create
    @guess_target = PlayerTargetFactory.get_player_target_by_name(params[:name])
    return unless @guess_target.present? && @guess_target.persisted?

    @game = Game.find(params[:game_id])
    @game.guesses.create(first_name: @guess_target.first_name,
                         last_name: @guess_target.last_name,
                         target_id: @guess_target.id)
    redirect_to game_path(id: params[:game_id])
  end

  def index
    @guesses = Guess.where(game_id: params[:game_id])
    render partial: 'game_guesses', locals: { guesses: @guesses }
  end

  def show
    @game = Game.find(params[:id])
  end
end
