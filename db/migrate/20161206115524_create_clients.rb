class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :email
      t.string :phone, null: false

      t.timestamps
    end

    add_index :clients, :phone, unique: true
  end
end
