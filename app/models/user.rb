
# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :orders

  validates :street, :province, presence: true
end



# app/models/product.rb
class Product < ApplicationRecord
  has_many :order_items
  has_many :cart_items

  # Additional fields: :price, :name, :description, :on_sale, etc.
end

# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items
end

# app/models/order_item.rb
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # Additional fields: :quantity, :unit_price, etc.
end

# app/models/cart.rb
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
end


# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  # Additional fields: :quantity, etc.
end

class Address < ApplicationRecord
  belongs_to :user
end


# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses

  # Additional fields: :name, :gst, :pst, :hst, etc.
end
