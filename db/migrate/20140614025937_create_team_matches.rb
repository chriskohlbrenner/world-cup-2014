class CreateTeamMatches < ActiveRecord::Migration
  def change
    create_table :team_matches do |t|
      t.integer :team_id
      t.integer :match_id
      t.boolean :home_team
      t.timestamps
    end
  end
end
