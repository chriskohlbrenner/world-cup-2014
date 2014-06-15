class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :api_id
      t.string :name
      t.string :logo
      t.string :website
      t.string :group_letter
      t.integer :group_rank
      t.integer :group_points
      t.integer :matches_played
      t.integer :wins
      t.integer :losses
      t.integer :draws
      t.integer :goals_for
      t.integer :goals_against
      t.string  :goal_differential
      t.timestamps
    end
  end
end