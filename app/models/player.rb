class Player < ActiveRecord::Base
  has_one :team, :through => :team_players

end
