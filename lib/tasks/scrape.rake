require 'nokogiri'
require 'open-uri'

namespace :scrape do
  desc "Scrape products from example.com"
  task products: :environment do
    url = 'http://127.0.0.1:3001/'
    doc = Nokogiri::HTML(URI.open(url))

    doc.css('.product').each do |product_html|
      product = Product.create(
        name: product_html.css('.product-name').text,
        description: product_html.css('.product-description').text,
        price: product_html.css('.product-price').text.gsub(/[^\d\.]/, '').to_f,
        stock_quantity: rand(1..100)
      )
      category_name = product_html.css('.product-category').text
      category = Category.find_or_create_by(name: category_name)
      product.categories << category
    end
  end
end
