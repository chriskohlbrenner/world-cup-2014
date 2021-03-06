class Team < ActiveRecord::Base
  belongs_to :group, primary_key: "group_letter"
  has_many :players
  has_many :team_matches
  has_many :matches, :through => :team_matches

  # attr_accessor :api_id, :name, :logo, :website, :group, :group_rank, :group_points, :matches_played, :wins, :losses, :draws, :goals_for, :goals_against, :goal_differential
  def next_match
    games = matches.where.not(status: "Final").order(:start_time)
    games.first
  end

  def next_opponent
    if next_match.home_team_id == self.api_id
      Team.find_by(api_id: next_match.away_team_id)
    else
      Team.find_by(api_id: next_match.home_team_id)
    end
  end

  def group
    Group.find_by(group_letter: self.group_letter)
  end

  def avg_goals_against
    (goals_against.to_f / matches_played).round(2)
  end

  def avg_goals_for
    (goals_for.to_f / matches_played).round(2)
  end
end
