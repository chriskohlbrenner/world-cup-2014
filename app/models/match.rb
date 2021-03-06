class Match < ActiveRecord::Base
  has_many :team_matches
  has_many :teams, :through => :team_matches
  has_many :match_stats

  # attr_accessor :api_id, :start_time, :home_team_id, :away_team_id, :home_score, :away_score, :status, :current_game_minutes, :venue
  def self.matches_in_progress
    where(status: "In-progress")
  end

  def self.next_match
    where(status: "Pre-game").order(:start_time).first
  end

  def self.next_matches(num)
    where(status: "Pre-game").order(:start_time).limit(num)
  end

  def self.last_match
    where(status: "Final").order(start_time: :desc).first
  end

  def self.previous_matches(num)
    where(status: "Final").order(start_time: :desc).limit(num)
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

  def goals
    match_stats.where('(event_type= ?) OR (event_type= ?) OR (event_type= ?)', "goal", "goal-own", "goal-penalty")
  end

  def current_match_stats(home_or_away)
    if (order_id && MatchStat.json_data)
      MatchStat.json_data[self.order_id-1]["#{home_or_away}_team_events"]
    end
  end
end