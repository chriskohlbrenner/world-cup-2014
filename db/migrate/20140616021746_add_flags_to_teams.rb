class AddFlagsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :flag, :string
  end
end
