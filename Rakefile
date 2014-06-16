# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

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

  task :flags => :environment do
    teams = Team.all
    teams.each do |team|
      team_code = @iso_country_codes[team.name]
      team.flag = "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/" + team_code.downcase + ".png" unless team_code.nil?
      team.save
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
end

@iso_country_codes = {
    "Andorra" => "AD",
    "United Arab Emirates" => "AE",
    "Afghanistan" => "AF",
    "Antigua and Barbuda" => "AG",
    "Anguilla" => "AI",
    "Albania" => "AL",
    "Armenia" => "AM",
    "Angola" => "AO",
    "Antarctica" => "AQ",
    "Argentina" => "AR",
    "American Samoa" => "AS",
    "Austria" => "AT",
    "Australia" => "AU",
    "Aruba" => "AW",
    "Åland Islands" => "AX",
    "Azerbaijan" => "AZ",
    "Bosnia-Herzegovina" => "BA",
    "Barbados" => "BB",
    "Bangladesh" => "BD",
    "Belgium" => "BE",
    "Burkina Faso" => "BF",
    "Bulgaria" => "BG",
    "Bahrain" => "BH",
    "Burundi" => "BI",
    "Benin" => "BJ",
    "Saint Barthélemy" => "BL",
    "Bermuda" => "BM",
    "Brunei Darussalam" => "BN",
    "Bolivia, Plurinational State of" => "BO",
    "Bonaire, Sint Eustatius and Saba" => "BQ",
    "Brazil" => "BR",
    "Bahamas" => "BS",
    "Bhutan" => "BT",
    "Bouvet Island" => "BV",
    "Botswana" => "BW",
    "Belarus" => "BY",
    "Belize" => "BZ",
    "Canada" => "CA",
    "Cocos (Keeling) Islands" => "CC",
    "Congo, the Democratic Republic of the" => "CD",
    "Central African Republic" => "CF",
    "Congo" => "CG",
    "Switzerland" => "CH",
    "Côte d'Ivoire" => "CI",
    "Cook Islands" => "CK",
    "Chile" => "CL",
    "Cameroon" => "CM",
    "China" => "CN",
    "Colombia" => "CO",
    "Costa Rica" => "CR",
    "Cuba" => "CU",
    "Cape Verde" => "CV",
    "Curaçao" => "CW",
    "Christmas Island" => "CX",
    "Cyprus" => "CY",
    "Czech Republic" => "CZ",
    "Germany" => "DE",
    "Djibouti" => "DJ",
    "Denmark" => "DK",
    "Dominica" => "DM",
    "Dominican Republic" => "DO",
    "Algeria" => "DZ",
    "Ecuador" => "EC",
    "Estonia" => "EE",
    "Egypt" => "EG",
    "Western Sahara" => "EH",
    "Eritrea" => "ER",
    "Spain" => "ES",
    "Ethiopia" => "ET",
    "Finland" => "FI",
    "Fiji" => "FJ",
    "Falkland Islands (Malvinas)" => "FK",
    "Micronesia, Federated States of" => "FM",
    "Faroe Islands" => "FO",
    "France" => "FR",
    "Gabon" => "GA",
    "England" => "GB",
    "Grenada" => "GD",
    "Georgia" => "GE",
    "French Guiana" => "GF",
    "Guernsey" => "GG",
    "Ghana" => "GH",
    "Gibraltar" => "GI",
    "Greenland" => "GL",
    "Gambia" => "GM",
    "Guinea" => "GN",
    "Guadeloupe" => "GP",
    "Equatorial Guinea" => "GQ",
    "Greece" => "GR",
    "South Georgia and the South Sandwich Islands" => "GS",
    "Guatemala" => "GT",
    "Guam" => "GU",
    "Guinea-Bissau" => "GW",
    "Guyana" => "GY",
    "Hong Kong" => "HK",
    "Heard Island and McDonald Islands" => "HM",
    "Honduras" => "HN",
    "Croatia" => "HR",
    "Haiti" => "HT",
    "Hungary" => "HU",
    "Indonesia" => "ID",
    "Ireland" => "IE",
    "Israel" => "IL",
    "Isle of Man" => "IM",
    "India" => "IN",
    "British Indian Ocean Territory" => "IO",
    "Iraq" => "IQ",
    "Iran" => "IR",
    "Iceland" => "IS",
    "Italy" => "IT",
    "Jersey" => "JE",
    "Jamaica" => "JM",
    "Jordan" => "JO",
    "Japan" => "JP",
    "Kenya" => "KE",
    "Kyrgyzstan" => "KG",
    "Cambodia" => "KH",
    "Kiribati" => "KI",
    "Comoros" => "KM",
    "Saint Kitts and Nevis" => "KN",
    "Korea, Democratic People's Republic of" => "KP",
    "Korea Republic" => "KR",
    "Kuwait" => "KW",
    "Cayman Islands" => "KY",
    "Kazakhstan" => "KZ",
    "Lao People's Democratic Republic" => "LA",
    "Lebanon" => "LB",
    "Saint Lucia" => "LC",
    "Liechtenstein" => "LI",
    "Sri Lanka" => "LK",
    "Liberia" => "LR",
    "Lesotho" => "LS",
    "Lithuania" => "LT",
    "Luxembourg" => "LU",
    "Latvia" => "LV",
    "Libya" => "LY",
    "Morocco" => "MA",
    "Monaco" => "MC",
    "Moldova, Republic of" => "MD",
    "Montenegro" => "ME",
    "Saint Martin (French part)" => "MF",
    "Madagascar" => "MG",
    "Marshall Islands" => "MH",
    "Macedonia, the former Yugoslav Republic of" => "MK",
    "Mali" => "ML",
    "Myanmar" => "MM",
    "Mongolia" => "MN",
    "Macao" => "MO",
    "Northern Mariana Islands" => "MP",
    "Martinique" => "MQ",
    "Mauritania" => "MR",
    "Montserrat" => "MS",
    "Malta" => "MT",
    "Mauritius" => "MU",
    "Maldives" => "MV",
    "Malawi" => "MW",
    "Mexico" => "MX",
    "Malaysia" => "MY",
    "Mozambique" => "MZ",
    "Namibia" => "NA",
    "New Caledonia" => "NC",
    "Niger" => "NE",
    "Norfolk Island" => "NF",
    "Nigeria" => "NG",
    "Nicaragua" => "NI",
    "Netherlands" => "NL",
    "Norway" => "NO",
    "Nepal" => "NP",
    "Nauru" => "NR",
    "Niue" => "NU",
    "New Zealand" => "NZ",
    "Oman" => "OM",
    "Panama" => "PA",
    "Peru" => "PE",
    "French Polynesia" => "PF",
    "Papua New Guinea" => "PG",
    "Philippines" => "PH",
    "Pakistan" => "PK",
    "Poland" => "PL",
    "Saint Pierre and Miquelon" => "PM",
    "Pitcairn" => "PN",
    "Puerto Rico" => "PR",
    "Palestinian Territory, Occupied" => "PS",
    "Portugal" => "PT",
    "Palau" => "PW",
    "Paraguay" => "PY",
    "Qatar" => "QA",
    "Réunion" => "RE",
    "Romania" => "RO",
    "Serbia" => "RS",
    "Russia" => "RU",
    "Rwanda" => "RW",
    "Saudi Arabia" => "SA",
    "Solomon Islands" => "SB",
    "Seychelles" => "SC",
    "Sudan" => "SD",
    "Sweden" => "SE",
    "Singapore" => "SG",
    "Saint Helena, Ascension and Tristan da Cunha" => "SH",
    "Slovenia" => "SI",
    "Svalbard and Jan Mayen" => "SJ",
    "Slovakia" => "SK",
    "Sierra Leone" => "SL",
    "San Marino" => "SM",
    "Senegal" => "SN",
    "Somalia" => "SO",
    "Suriname" => "SR",
    "South Sudan" => "SS",
    "Sao Tome and Principe" => "ST",
    "El Salvador" => "SV",
    "Sint Maarten (Dutch part)" => "SX",
    "Syrian Arab Republic" => "SY",
    "Swaziland" => "SZ",
    "Turks and Caicos Islands" => "TC",
    "Chad" => "TD",
    "French Southern Territories" => "TF",
    "Togo" => "TG",
    "Thailand" => "TH",
    "Tajikistan" => "TJ",
    "Tokelau" => "TK",
    "Timor-Leste" => "TL",
    "Turkmenistan" => "TM",
    "Tunisia" => "TN",
    "Tonga" => "TO",
    "Turkey" => "TR",
    "Trinidad and Tobago" => "TT",
    "Tuvalu" => "TV",
    "Taiwan, Province of China" => "TW",
    "Tanzania, United Republic of" => "TZ",
    "Ukraine" => "UA",
    "Uganda" => "UG",
    "United States Minor Outlying Islands" => "UM",
    "United States" => "US",
    "Uruguay" => "UY",
    "Uzbekistan" => "UZ",
    "Holy See (Vatican City State)" => "VA",
    "Saint Vincent and the Grenadines" => "VC",
    "Venezuela, Bolivarian Republic of" => "VE",
    "Virgin Islands, British" => "VG",
    "Virgin Islands, U.S." => "VI",
    "Viet Nam" => "VN",
    "Vanuatu" => "VU",
    "Wallis and Futuna" => "WF",
    "Samoa" => "WS",
    "Yemen" => "YE",
    "Mayotte" => "YT",
    "South Africa" => "ZA",
    "Zambia" => "ZM",
    "Zimbabwe" => "ZW"
}