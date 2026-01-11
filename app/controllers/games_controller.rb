class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
    @player_target = PlayerTargetFactory.get_random_player_target
    @game = Game.new(player_target: @player_target)
    if @game.save
      redirect_to game_path(id: @game.id), notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @guesses = @game.guesses
  end
end
