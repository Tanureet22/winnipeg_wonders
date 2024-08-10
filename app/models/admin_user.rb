class AdminUser < ApplicationRecord

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable


  def self.ransackable_attributes(auth_object = nil)
       %w[id email created_at current_sign_in_at last_sign_in_at sign_in_count updated_at]
     end
end
