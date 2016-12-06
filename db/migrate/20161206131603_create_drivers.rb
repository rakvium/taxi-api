class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone
      t.string :pass
      t.string :auto
      t.string :status

      t.timestamps
    end
  end
end
