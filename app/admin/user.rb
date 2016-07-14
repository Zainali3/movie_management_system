ActiveAdmin.register User do

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

permit_params :full_name, :email, :password

  index do
    column :full_name
    column :email
    column :created_at
    column "Image" do |m|
      image_tag(m.attachment.image.url(:thumb)) if m.attachment
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :email
      f.input :password
    end
    f.actions
  end

end
