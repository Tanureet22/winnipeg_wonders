# app/admin/orders.rb
ActiveAdmin.register Order do
  permit_params :status

  index do
    selectable_column
    id_column
    column :user
    column :total_amount
    column :tax_amount
    column :status
    actions
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: ['new', 'paid', 'shipped']
    end
    f.actions
  end
end
