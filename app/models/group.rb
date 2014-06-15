class Group < ActiveRecord::Base
  has_many :teams

  def teams
    Team.where(group_letter: self.group_letter)
  end
end
