class CreateMatchStats < ActiveRecord::Migration
  def change
    create_table :match_stats do |t|

      t.timestamps
    end
  end
end
