class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @matches = Match.all
    @next_match = Match.next_match
    @recent_match = Match.last_match
    @current_matches = []
    @matches.each do |match|
      @current_matches << match if match.status == "In-progress"
    end
  end
end
