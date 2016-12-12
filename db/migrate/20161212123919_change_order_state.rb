class ChangeOrderState < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :state, from: nil, to: "active"
  end
end
