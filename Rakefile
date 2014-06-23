# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# Run the following locally to reset db:
# rake db:drop
# rake db:migrate
# rake populate:groups
# rake populate:teams
# rake populate:matches
# rake populate:team_matches
# rake populate:players
# rake populate:match_order_id
# rake populate:match_events

# Run the following for Heroku deployment:
# heroku run rake db:drop
# heroku run rake db:migrate
# heroku run rake populate:groups
# heroku run rake populate:teams
# heroku run rake populate:matches
# heroku run rake populate:team_matches
# heroku run rake populate:players
# heroku run rake populate:match_order_id
# heroku run rake populate:match_events

require File.expand_path('../config/application', __FILE__)
require 'net/http'

Rails.application.load_tasks

namespace :populate do
  task :groups => :environment do
    ["A","B","C","D","E","F","G","H"].each do |letter|
      new_group = Group.new
      new_group.group_letter = letter
      new_group.save
    end
  end

  task :teams => :environment do
    response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/teams?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
    teams = JSON.parse(response.body)
    teams.each do |api_team|
      team = Team.new
      team.api_id = api_team["id"]
      team.name = api_team["name"]
      team.logo = api_team["logo"]
      team.website = api_team["website"]
      team.group_letter = api_team["group"]
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

  task :players => :environment do
    Team.all.each do |team|
      response = Net::HTTP.get_response("worldcup.kimonolabs.com","/api/players?teamId=#{team.api_id}&apikey=f4552154b80ab28c8ab1a4a1adca9ebe")
      players = JSON.parse(response.body)
      players.each do |api_player|
        player = Player.new
        player.first_name = api_player["firstName"]
        player.last_name = api_player["lastName"]
        player.nickname = api_player["nickname"]
        player.nationality = api_player["nationality"]
        player.age = api_player["age"]
        player.birth_date = api_player["birthDate"]
        player.birth_country = api_player["birthCountry"]
        player.birth_city = api_player["birthCity"]
        player.position = api_player["position"]
        player.foot = api_player["foot"]
        player.image = api_player["image"]
        player.height_cm = api_player["heightCm"]
        player.weight_kg = api_player["weightKg"]
        player.goals = api_player["goals"]
        player.own_goals = api_player["ownGoals"]
        player.penalty_goals = api_player["penaltyGoals"]
        player.assists = api_player["assists"]
        player.club_id = api_player["clubId"]
        player.team_api_id = api_player["teamId"]
        player.team_id = Team.find_by(api_id: api_player["teamId"]).id
        player.api_id = api_player["id"]
        player.type = api_player["type"]
        player.save
      end
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

  # Set match order ids for group play games, to pull in-game stats from http://worldcup.sfg.io/matches
  task :match_order_id => :environment do
    match_stats = MatchStat.json_data
    match_stats[0..47].each do |match_stat|
      ht = Team.find_by(name: match_stat["home_team"]["country"])
      at = Team.find_by(name: match_stat["away_team"]["country"])
      if (match_stat["home_team"]["country"] == "Ivory Coast")
        ht = Team.find_by(name: "Côte d'Ivoire")
      elsif (match_stat["away_team"]["country"] == "Ivory Coast")
        at = Team.find_by(name: "Côte d'Ivoire")
      elsif (match_stat["home_team"]["country"] == "USA")
        ht = Team.find_by(name: "United States")
      elsif (match_stat["away_team"]["country"] == "USA")
        at = Team.find_by(name: "United States")
      elsif (match_stat["home_team"]["country"] == "Bosnia and Herzegovina")
        ht = Team.find_by(name: "Bosnia-Herzegovina")
      elsif (match_stat["away_team"]["country"] == "Bosnia and Herzegovina")
        at = Team.find_by(name: "Bosnia-Herzegovina")
      end
        match = Match.where(:home_team_id => ht.api_id, :away_team_id => at.api_id).first
        match.order_id = match_stat["match_number"]
        match.save
      puts "#{match.teams.first.name} vs. #{match.teams.last.name}"
    end
  end

  task :match_events => :environment do
    matches = Match.all
    match_stats = MatchStat.json_data
    matches.each do |match|
      match_home_events = match_stats[match.order_id-1]["home_team_events"]
      match_home_events.each do |match_stat|
        event = MatchStat.new
        event.event_type = match_stat["type_of_event"]
        event.player = match_stat["player"]
        event.minute = match_stat["time"]
        event.home_away = "home"
        event.match_id = match.id
        event.save
      end
      match_away_events = match_stats[match.order_id-1]["away_team_events"]
      match_away_events.each do |match_stat|
        event = MatchStat.new
        event.event_type = match_stat["type_of_event"]
        event.player = match_stat["player"]
        event.minute = match_stat["time"]
        event.home_away = "away"
        event.match_id = match.id
        event.save
      end
    end
  end  
end

namespace :update do
  task :game_results => :environment do
    response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/matches?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
    matches = JSON.parse(response.body)
    matches.each do |api_match|
      local_match = Match.find_by(api_id: api_match["id"])
      local_match.update_attributes(status: api_match["status"], current_game_minutes: api_match["currentGameMinute"], home_score: api_match["homeScore"], away_score: api_match["awayScore"])
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

  task :players => :environment do
    players = Player.all
    puts "There are #{players.count} players - this will take a minute."
    players.each do |player|
      response = Net::HTTP.get_response("worldcup.kimonolabs.com","/api/players/#{player.api_id}?apikey=f4552154b80ab28c8ab1a4a1adca9ebe")       
      api_player = JSON.parse(response.body)
      player.goals = api_player["goals"]
      player.own_goals = api_player["ownGoals"]
      player.penalty_goals = api_player["penaltyGoals"]
      player.assists = api_player["assists"]
      player.save
      puts "Updating player number #{player.id}..." if player.id % 5 == 0
    end
  end

  task :match_events => :environment do
    MatchStat.destroy_all
    matches = Match.all
    match_stats = MatchStat.json_data
    matches.each do |match|
      match_home_events = match_stats[match.order_id-1]["home_team_events"]
      match_home_events.each do |match_stat|
        event = MatchStat.new
        event.event_type = match_stat["type_of_event"]
        event.player = match_stat["player"]
        event.minute = match_stat["time"]
        event.home_away = "home"
        event.match_id = match.id
        event.save
      end
      match_away_events = match_stats[match.order_id-1]["away_team_events"]
      match_away_events.each do |match_stat|
        event = MatchStat.new
        event.event_type = match_stat["type_of_event"]
        event.player = match_stat["player"]
        event.minute = match_stat["time"]
        event.home_away = "away"
        event.match_id = match.id
        event.save
      end
    end
    # Need to write this
      # Need games in progress to pull match events in realtime
      # Need rake task to persist to database every 10?
      # Dirty checking?
  end  
end