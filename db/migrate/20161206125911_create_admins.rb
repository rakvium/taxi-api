class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end

  attr_accessor :name, :email, :password
  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
    @password = attributes[:password]
  end
end
