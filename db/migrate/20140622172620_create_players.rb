class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :nationality
      t.integer :age
      t.datetime :birth_date
      t.string :birth_country
      t.string :birth_city
      t.string :position
      t.string :foot
      t.string :image
      t.integer :height_cm
      t.integer :weight_kg
      t.integer :goals
      t.integer :own_goals
      t.integer :penalty_goals
      t.integer :assists
      t.string :club_id
      t.string :team_api_id
      t.string :team_id
      t.string :api_id
      t.string :type
      t.timestamps
    end
  end
end
