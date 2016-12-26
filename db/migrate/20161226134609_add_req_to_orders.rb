class AddReqToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :req, :boolean, default: false
  end
end
