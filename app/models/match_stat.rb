class MatchStat < ActiveRecord::Base
  belongs_to :match

  def self.json_data
    response = Net::HTTP.get_response('worldcup.sfg.io','/matches')
    if response.kind_of?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      puts "API is down."
      false
    end
  end

  def team
    if home_away == "home"
      Team.find_by(api_id: self.match.home_team_id).name
    elsif home_away == "away"
      Team.find_by(api_id: self.match.away_team_id).name
    end
  end

  def opponent
    if home_away == "home"
      Team.find_by(api_id: self.match.away_team_id).name
    elsif home_away == "away"
      Team.find_by(api_id: self.match.home_team_id).name
    end
  end

  def display
    case event_type
    when "goal"
      "Goal scored by #{player}."
    when "goal-penalty"
      "Goal. #{player} scored on a PK."
    when "goal-own"
      "Goal #{opponent}. #{self.player} scored an own goal."
    when "yellow-card"
      "Foul on #{player}--given a yellow card."
    when "red-card"
      "Foul on #{player}--given a red card."
    when "substitution-in"
      "#{player} came in as a sub."
    when "substitution-in halftime"
      "#{player} came in as a halftime sub."
    end
  end
end
