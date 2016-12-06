class CreateDispatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :dispatchers do |t|
      t.string :email, :unique => true, :null => false
      t.string :password, :null => false
      t.string :name, :null => false

      t.timestamps
    end
  end
end
