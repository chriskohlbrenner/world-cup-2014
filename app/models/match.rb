class Match < ActiveRecord::Base
  has_many :team_matches
  has_many :teams, :through => :team_matches

  # attr_accessor :api_id, :start_time, :home_team_id, :away_team_id, :home_score, :away_score, :status, :current_game_minutes, :venue
  def self.matches_in_progress
    games = where(status: "In-progress")
  end

  def self.next_match
    games = where(status: "Pre-game").order(:start_time)
    games.first
  end

  def self.last_match
    games = where(status: "Final").order(:start_time)
    games.last
  end

  def display_time
    start_time.in_time_zone('Eastern Time (US & Canada)').strftime("%A, %B %e, at %l:%M %p EDT")
  end

  def winner?
    (status == "Final") && (home_score != away_score)
  end

  def winner
    return nil if !winner?
    if home_score > away_score
      Team.find_by(api_id: home_team_id)
    else
      Team.find_by(api_id: away_team_id)
    end
  end

  def loser
    return nil if !winner?
    if winner != teams[0]
      teams[0]
    else
      teams[1]
    end
  end
end