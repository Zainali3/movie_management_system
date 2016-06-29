class Movie < ActiveRecord::Base
  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :posters, allow_destroy: true
  has_many :casts
  has_many :actors, through: :casts
end
