# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.create(phone: '1234567890')
Client.create(phone: '1112223334', email: 'a@example.com')
Client.create(phone: '0987654321', email: 'a1@example.com')

Admin.create(name: 'admin1', email: 'admin1@example.com', password: '123456')
Admin.create(name: 'admin2', email: 'admin2@example.com', password: '567890')

Dispatcher.create(name: 'dispatcher1', email: 'dispatcher1@example.com', password: '654321')
Dispatcher.create(name: 'dispatcher2', email: 'dispatcher2@example.com', password: '098765')

Driver.create(name: 'driver1', phone: '0000000000', password: '000000', auto: 'test')
Driver.create(name: 'driver2', phone: '1111111111', password: '111111', auto: 'test', status: 'active')
Driver.create(name: 'driver3', phone: '2222222222', password: '222222', auto: 'test')

Order.create(client_id: '1', from: 'work', to: 'home')
Order.create(client_id: '2', driver_id: '1', from: 'home', to: 'work', state: 'active')
Order.create(client_id: '3', from: 'somewhere', to: 'anywhere')
Order.create(client_id: '1', driver_id: '2', from: 'work', to: 'home', state: 'completed')
