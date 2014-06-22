class TeamsController < ApplicationController
  def index
    @teams = Team.all.order(:name)
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.players.order(goals: :desc)
    @matches = @team.matches.order(:start_time)
  end
end
