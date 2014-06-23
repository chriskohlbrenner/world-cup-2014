class CreateMatchStats < ActiveRecord::Migration
  def change
    create_table :match_stats do |t|
      t.integer :match_id
      t.integer :minute
      t.string  :player
      t.string  :home_away
      t.string  :type
      t.timestamps
    end
  end
end
