class CreateD3s < ActiveRecord::Migration
  def change
    create_table :d3s do |t|

      t.timestamps
    end
  end
end
