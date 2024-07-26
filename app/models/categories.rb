ActiveAdmin.register Category do
  permit_params :name, product_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :products, as: :check_boxes
    end
    f.actions
  end
end

