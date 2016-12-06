class CreateDispatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :dispatchers do |t|
      t.string :email
      t.string :password
      t.string :name

      t.timestamps
    end
  end
end
