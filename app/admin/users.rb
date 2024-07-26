ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, address_attributes: [:street, :city, :province, :postal_code]

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.inputs 'Address Details' do
      f.inputs :address, for: [:address, f.object.address || Address.new] do |a|
        a.input :street
        a.input :city
        a.input :province
        a.input :postal_code
      end
    end

    f.actions
  end
end
