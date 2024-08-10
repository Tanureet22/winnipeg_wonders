class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :cart_id, presence: true

  def total_price
    product.price * quantity
  end
end
