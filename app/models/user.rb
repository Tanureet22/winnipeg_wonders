# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :orders
  has_one :cart, dependent: :destroy

  scope :by_address_street, -> (street) { joins(:address).where('addresses.street LIKE ?', "%#{street}%") }
  scope :by_address_city, -> (city) { joins(:address).where('addresses.city LIKE ?', "%#{city}%") }
  scope :by_address_province, -> (province) { joins(:address).where('addresses.province LIKE ?', "%#{province}%") }
  scope :by_address_postal_code, -> (postal_code) { joins(:address).where('addresses.postal_code LIKE ?', "%#{postal_code}%") }

  def self.ransackable_associations(auth_object = nil)
    ["orders", "cart"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[
      created_at
      current_sign_in_at
      current_sign_in_ip
      email
      id
      sign_in_count
      updated_at
    ]
  end
end

