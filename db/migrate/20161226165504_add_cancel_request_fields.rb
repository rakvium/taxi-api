class AddCancelRequestFields < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :cancel_request, :boolean, default: :false
    add_column :orders, :cancel_comment, :text
  end
end
