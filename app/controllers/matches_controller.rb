class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(:start_time)
  end

  def show
    @match = Match.find(params[:id])
  end

end
