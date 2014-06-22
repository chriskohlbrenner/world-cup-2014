class PlayersController < ApplicationController
  def index
    @goal_max = Player.maximum("goals")
    @top_scorers = Player.where(goals: @goal_max) + Player.where(goals: @goal_max-1)
    @teams = Team.all.order(:name)
  end

  def show
    @player = Player.find(params[:id])
  end
end
