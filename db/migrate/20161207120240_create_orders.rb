class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :client, foreign_key: true
      t.references :driver, foreign_key: true
      t.string :from, null: false
      t.string :to, null: false
      t.string :state, null: false
      t.decimal :price, precision: 5, scale: 2
      t.text :comment

      t.timestamps
    end
  end
end
