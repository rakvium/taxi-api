# add admin entity to database
class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false

      t.timestamps
    end

    add_index :admins, :email, unique: true
  end
end
