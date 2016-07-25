ActiveAdmin.register Movie do

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

  permit_params :title, :description, :trailer, :release_date, :duration, :genre, :featured, :approved, posters_attributes: [:id, :image, :_destroy], actor_ids: []

  index do
    column :title
    column :description
    column :featured
    column :approved
    column :release_date
    column :actors do |movie|
      movie.movie_cast
    end
    column "Poster" do |m|
      image_tag(m.first_poster.image.url(:thumb)) if m.first_poster
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :trailer
      f.input :featured
      f.input :approved
      f.input :duration
      f.input :genre, as: :select, collection: Movie::OPTIONS
      f.input :release_date, as: :datepicker
      f.input :actors
      f.has_many :posters, heading: 'Posters', new_record: 'Add Poster' do |attachment|
       attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:thumb)), allow_destroy: true
       attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
     end
    end
    f.actions
  end

end
