class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :name,   null: false
      t.string :phone,  null: false
      t.string :pass,   null: false
      t.string :auto,   null: false
      t.string :status, default: "not active"

      t.timestamps
    end

    add_index :drivers, :phone, unique: true
  end
end
