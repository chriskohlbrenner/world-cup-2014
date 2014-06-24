class D3Controller < ApplicationController
  def index
    # [player, goal #]
    gon.player_goals = Player.order(goals: :desc).limit(20).collect {|player| [player.nickname + ", " + player.team.name, player.image, player.goals]}
    gon.team_goals = Team.order(goals_for: :desc).collect {|team| [team.name, team.logo, team.goals_for, team.avg_goals_for]}
  end
end
