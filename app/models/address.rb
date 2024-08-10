class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :street, :city, :province, :postal_code, presence: true
  
end
