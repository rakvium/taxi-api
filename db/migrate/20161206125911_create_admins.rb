# add admin entity to database
class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email, unique: true, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
