ActiveAdmin.register Page do
  permit_params :title, :content

  form do |f|
    f.inputs 'Page Details' do
      f.input :title, as: :select, collection: ['Contact', 'About']
      f.input :content, as: :quill_editor # Requires the `activeadmin_quill_editor` gem
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :content do |page|
      truncate(page.content, length: 100)
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :content do |page|
        raw page.content
      end
    end
  end
end
