class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    gon.teams = Team.pluck(:name)
    gon.logos = Team.all.map { |team| team.logo }
    @groups = Group.all
    @matches = Match.all
    @next_match = Match.next_matches(2).first
    @second_match = Match.next_matches(2).last
    @recent_match = Match.previous_matches(2).first
    @two_previous_match = Match.previous_matches(2).last
    @current_matches = []
    @matches.each do |match|
      @current_matches << match if match.status == "In-progress"
    end
    @goal_max = Player.maximum("goals")
    @top_scorers = Player.where(goals: @goal_max) + Player.where(goals: @goal_max-1)
  end

  def search
    binding.pry
  end

end