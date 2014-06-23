class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by(group_letter: params[:letter].capitalize)
    @top_scorers = @group.players.sort { |a,b| b.goals <=> a.goals }
  end

end
