class Product < ApplicationRecord
  has_many :order_items
  has_many :cart_items
  has_many :products
  has_one_attached :image
  has_and_belongs_to_many :categories

end

class Product < ApplicationRecord
  belongs_to :category

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where('created_at < ?', 3.days.ago) }

  paginates_per 10
end

class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end

class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
end
