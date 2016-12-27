# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

first_client = Client.first_or_create(phone: '1234567890')
second_client = Client.first_or_create(phone: '1112223334', email: 'a@example.com')
third_client = Client.first_or_create(phone: '0987654321', email: 'a1@example.com')

Admin.first_or_create(name: 'admin1', email: 'admin1@example.com', password: '123456')
Admin.first_or_create(name: 'admin2', email: 'admin2@example.com', password: '567890')

Dispatcher.first_or_create(name: 'dispatcher1', email: 'dispatcher1@example.com', password: '654321')
Dispatcher.first_or_create(name: 'dispatcher2', email: 'dispatcher2@example.com', password: '098765')

driver1 = Driver.first_or_create(name: 'driver1', phone: '0000000000', password: '000000', auto: 'test')
driver2 = Driver.first_or_create(name: 'driver2',
                                 phone: '1111111111', password: '111111', auto: 'test', status: 'active')
Driver.first_or_create(name: 'driver3', phone: '2222222222', password: '222222', auto: 'test')

Order.first_or_create(client_id: first_client.id, from: 'work', to: 'home')
Order.first_or_create(client_id: second_client.id, driver_id: driver1.id, from: 'home', to: 'work', state: 'active')
Order.first_or_create(client_id: third_client.id, from: 'somewhere', to: 'anywhere')
Order.first_or_create(client_id: first_client.id, driver_id: driver2.id, from: 'work', to: 'home', state: 'completed')
