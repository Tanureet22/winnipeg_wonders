# db/seeds.rb
require 'faker'

4.times do
  Category.create(name: Faker::Commerce.department)
end

100.times do
  product = Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 100)
  )
  product.categories << Category.order('RANDOM()').first
end
Province.create([
  { name: 'Ontario', gst: 5, pst: 8, hst: 13 },
  { name: 'Quebec', gst: 5, pst: 9.975, hst: 0 },
  # Add other provinces and their tax rates
])

Product.create([
  { name: 'Product 1', description: 'Description for product 1', price: 10.00, on_sale: true },
  { name: 'Product 2', description: 'Description for product 2', price: 20.00, on_sale: false },
  # Add more products
])
