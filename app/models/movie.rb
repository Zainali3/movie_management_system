class Movie < ActiveRecord::Base
  paginates_per 2
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
  validates :description, presence: true
  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :posters, allow_destroy: true
  has_many :casts , dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews

  OPTIONS = ["Action", "Funny", "Thriller", "Horror"]

  def first_poster
    posters.first
  end
  scope :featured_movie, -> { where(featured: true) }
  scope :latest_movie, -> { order("release_date DESC") }
end
