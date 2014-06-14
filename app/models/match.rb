class Match < ActiveRecord::Base
  has_many :team_matches
  has_many :teams, :through => :team_matches

  # attr_accessor :api_id, :start_time, :home_team_id, :away_team_id, :home_score, :away_score, :status, :current_game_minutes, :venue
end