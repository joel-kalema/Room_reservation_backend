# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

julie = User.create!(name: 'mike', email: 'mike@gmail.com', password: '14361436')

room1 = Room.create!(name: 'Room1', city: 'Abuja', rate: '100', room_type: 'children', amenities: 'big room', picture: 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg', user_id: julie.id, price: '100')

reservation = Reservation.create!(check_in: '2022-02-1', check_out: '2022-02-6', room_id: room1.id, user_id: julie.id)