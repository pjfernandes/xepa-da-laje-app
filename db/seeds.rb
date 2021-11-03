# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  p = Product.create(
    name: Faker::Commerce.material,
    unit_price: Faker::Commerce.price,
    quantity: (0..10).to_a.sample,
    description: Faker::Commerce.product_name,
    user_id: rand(1..4)
  )
  puts "product #{p.id} created"
end
puts "DONE!"
#comment