ActiveAdmin.register Actor do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :name , :biography

  index do
    column :id
    column :name
    column :biography
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :biography
    end
    f.actions
  end

end
