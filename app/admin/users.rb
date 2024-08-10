ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, address_attributes: [:id, :street, :city, :province, :postal_code]

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.inputs 'Address Details' do
      f.inputs :address, allow_destroy: true, new_record: true do |a|
        a.input :street
        a.input :city
        a.input :province
        a.input :postal_code
      end
    end

    f.actions
  end

  filter :address_street, as: :string, label: 'Street'
  filter :address_city, as: :string, label: 'City'
  filter :address_province, as: :string, label: 'Province'
  filter :address_postal_code, as: :string, label: 'Postal Code'
end
