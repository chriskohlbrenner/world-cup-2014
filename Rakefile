# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'net/http'

Rails.application.load_tasks

namespace :populate do
  task :teams => :environment do
    response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/teams?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
    teams = JSON.parse(response.body)
    teams.each do |api_team|
      team = Team.new
      team.api_id = api_team["id"]
      team.name = api_team["name"]
      team.logo = api_team["logo"]
      team.website = api_team["website"]
      team.group = api_team["group"]
      team.group_rank = api_team["groupRank"]
      team.group_points = api_team["groupPoints"]
      team.matches_played = api_team["matchesPlayed"]
      team.wins = api_team["wins"]
      team.losses = api_team["losses"]
      team.draws = api_team["draws"]
      team.goals_for = api_team["goalsFor"]
      team.goals_against = api_team["goalsAgainst"]
      team.goal_differential = api_team["goalsDiff"]
      team.save
    end
  end

  task :matches => :environment do
    response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/matches?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
    matches = JSON.parse(response.body)
    matches.each do |api_match|
      match = Match.new
      match.api_id = api_match["id"]
      match.start_time = api_match["startTime"]
      match.home_team_id = api_match["homeTeamId"]
      match.away_team_id = api_match["awayTeamId"]
      match.home_score = api_match["homeScore"]
      match.away_score = api_match["awayScore"]
      match.status = api_match["status"]
      match.current_game_minutes = api_match["currentGameMinutes"]
      match.venue = api_match["venue"]
      match.save
    end
  end

  task :team_matches => :environment do
    matches = Match.all
    matches.each do |match|
      team_match_1 = TeamMatch.new
      team_match_2 = TeamMatch.new
      team_match_1.team_id = Team.find_by(api_id: match.home_team_id).id
      team_match_1.match_id = match.id
      team_match_1.home_team = true
      team_match_2.team_id = Team.find_by(api_id: match.away_team_id).id
      team_match_2.match_id = match.id
      team_match_2.home_team = false
      team_match_1.save
      team_match_2.save
    end
  end

  task :time_fix => :environment do
    matches = Match.all
    matches.each do |match|
      match.start_time += 79200 if match.start_time.strftime("%H %M") == "20 00"
      match.save
    end
  end

  task :subtract_four => :environment do
    matches = Match.all
    matches.each do |match|
      match.start_time -= 14400
      match.save
    end
  end
end

namespace :update do
  task :game_results => :environment do
    response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/matches?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
    matches = JSON.parse(response.body)
    matches.each do |api_match|
      local_match = Match.find_by(api_id: api_match["id"])
      local_match.update_attributes(status: api_match["status"], current_game_minutes: api_match["currentGameMinutes"], home_score: api_match["homeScore"], away_score: api_match["awayScore"])
    end
  end

  task :teams => :environment do
    response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/teams?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
    teams = JSON.parse(response.body)
    teams.each do |api_team|
      local_team = Team.find_by(name: api_team["name"])
      local_team.update_attributes(group_rank: api_team["groupRank"], group_points: api_team["groupPoints"], matches_played: api_team["matchesPlayed"], wins: api_team["wins"], losses: api_team["losses"], draws: api_team["draws"], goals_for: api_team["goalsFor"], goals_against: api_team["goalsAgainst"], goal_differential: api_team["goalsDiff"])
    end
  end
end