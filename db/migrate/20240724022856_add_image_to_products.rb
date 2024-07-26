# db/migrate/xxxxxx_add_image_to_products.rb
class AddImageToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :image, :string
  end
end
