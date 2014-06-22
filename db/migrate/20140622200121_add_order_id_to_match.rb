class AddOrderIdToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :order_id, :integer
  end
end
