class Match < ActiveRecord::Base
  has_many :team_matches
  has_many :teams, :through => :team_matches

  # attr_accessor :api_id, :start_time, :home_team_id, :away_team_id, :home_score, :away_score, :status, :current_game_minutes, :venue
  def self.next_match
    games = where.not(status: "Final").order(:start_time)
    games.first
  end

  def display_time
    start_time.in_time_zone('Eastern Time (US & Canada)').strftime("%A, %B %e, at %l:%M %p EDT")
  end
end