class AddBlockField < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :blocked, :boolean, default: false
    add_column :dispatchers, :blocked, :boolean, default: false
    add_column :drivers, :blocked, :boolean, default: false
    change_column_default :orders, :state, from: "active", to: "waiting"
  end
end
