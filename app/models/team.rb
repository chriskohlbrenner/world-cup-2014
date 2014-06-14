class Team < ActiveRecord::Base
  has_many :team_matches
  has_many :matches, :through => :team_matches

  # attr_accessor :api_id, :name, :logo, :website, :group, :group_rank, :group_points, :matches_played, :wins, :losses, :draws, :goals_for, :goals_against, :goal_differential
  def next_match
    games = matches.where.not(status: "Final").order(:start_time)
    games.first
  end
end
