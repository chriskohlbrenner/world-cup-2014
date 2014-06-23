class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(:start_time)
    @next_match = Match.next_matches(2).first
    @second_match = Match.next_matches(2).last
    @recent_match = Match.previous_matches(2).first
    @two_previous_match = Match.previous_matches(2).last
    @current_matches = []
    @matches.each do |match|
      @current_matches << match if match.status == "In-progress"
    end
  end

  def show
    @match = Match.find(params[:id])
    @home_match_stats = @match.match_stats.where(home_away: "home").order(:minute)
    @away_match_stats = @match.match_stats.where(home_away: "away").order(:minute)
  end

end
