class Product < ApplicationRecord
  has_many :order_items
  has_many :cart_items
  has_and_belongs_to_many :categories

  belongs_to :category

  has_one_attached :image

  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price stock_quantity category_id created_at updated_at]
  end

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where('created_at < ?', 3.days.ago) }
  scope :search, ->(keyword) { where("name ILIKE ? OR description ILIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present? }
  scope :filter_by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }

  paginates_per 10
end
