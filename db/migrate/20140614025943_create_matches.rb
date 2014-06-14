class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string  :api_id
      t.datetime  :start_time
      t.string  :home_team_id
      t.string  :away_team_id
      t.integer :home_score
      t.integer :away_score
      t.string  :status
      t.integer :current_game_minutes
      t.string  :venue
      t.timestamps
    end
  end
end