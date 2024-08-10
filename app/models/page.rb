class Page < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at"] # Adjust the attributes as needed
  end
  
end
