# require 'net/http'

# desc "Update game_results and team data with Heroku scheduler add-on"
# task :update_all => :environment do
  
#   puts "Updating game results..."
  
#   game_response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/matches?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
#   matches = JSON.parse(game_response.body)
#   matches.each do |api_match|
#     local_match = Match.find_by(api_id: api_match["id"])
#     local_match.update_attributes(status: api_match["status"], current_game_minutes: api_match["currentGameMinutes"], home_score: api_match["homeScore"], away_score: api_match["awayScore"])
#   end
  
#   puts "Done. Updating team data..."
  
#   team_response = Net::HTTP.get_response('worldcup.kimonolabs.com','/api/teams?apikey=f4552154b80ab28c8ab1a4a1adca9ebe')
#   teams = JSON.parse(team_response.body)
#   teams.each do |api_team|
#     local_team = Team.find_by(name: api_team["name"])
#     local_team.update_attributes(group_rank: api_team["groupRank"], group_points: api_team["groupPoints"], matches_played: api_team["matchesPlayed"], wins: api_team["wins"], losses: api_team["losses"], draws: api_team["draws"], goals_for: api_team["goalsFor"], goals_against: api_team["goalsAgainst"], goal_differential: api_team["goalsDiff"])
#   end
  
#   puts "Done."
# end