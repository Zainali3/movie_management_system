class Movie < ActiveRecord::Base

  paginates_per 2

  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
  validates :description, presence: true

  scope :featured_movie, -> { where(featured: true) }
  scope :latest_movie, -> { order("release_date DESC") }

  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :posters, allow_destroy: true
  has_many :casts , dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews, dependent: :destroy
  has_many :rates, dependent: :destroy

  def first_poster
    posters.first
  end

  def movie_cast
   self.actors.pluck(:name).join(', ')
 end

end
