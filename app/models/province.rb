class Province < ApplicationRecord
  has_many :addresses

   # Additional fields: :name, :gst, :pst, :hst, etc.
   
end
