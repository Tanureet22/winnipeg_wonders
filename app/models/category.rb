class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    %w[products]  # List the associations you want to make searchable
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name]  # List the attributes you want to make searchable
  end
  
end
