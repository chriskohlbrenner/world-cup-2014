class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by(group_letter: params[:letter].capitalize)
  end

end
