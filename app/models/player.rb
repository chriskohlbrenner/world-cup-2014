class Player < ActiveRecord::Base
  belongs_to :team

  def full_name
    first_name + " " + last_name
  end

  def group
    Group.find_by(group_letter: team.group_letter)
  end
end
