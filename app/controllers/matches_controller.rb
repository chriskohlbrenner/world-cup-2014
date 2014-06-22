class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(:start_time)
    @next_match = Match.next_match
    @recent_match = Match.last_match
    @current_matches = []
    @matches.each do |match|
      @current_matches << match if match.status == "In-progress"
    end
  end

  def show
    @match = Match.find(params[:id])
  end

end
