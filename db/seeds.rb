# db/seeds.rb
require 'faker'

categories = ['Pottery', 'Textiles', 'Jewelry', 'Artwork'].map do |category_name|


  Category.create(name: category_name)
end


100.times do
  product = Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price,
    stock_quantity: rand(1..100),
    category_ids: Category.pluck(:id).sample(2)
    category: categories.sample
  )
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
Page.create!(title: 'Contact', content: 'Contact us at contact@winnipegwonders.com')
Page.create!(title: 'About', content: 'Winnipeg Wonders is a local retail business established in 1995...')
product.image.attach(io: File.open('/path/to/image.jpg'), filename: 'image.jpg')
