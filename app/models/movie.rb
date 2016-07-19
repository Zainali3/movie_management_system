class Movie < ActiveRecord::Base

  paginates_per 8

  LATEST = 'latest'
  FEATURED = 'featured'
  TOP_RATED = 'top_rated'

  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
  validates :description, presence: true
  validates :posters, presence: true

  scope :featured_movie, -> { where(featured: true) }
  scope :latest_movie, -> { order("release_date DESC") }
  scope :movie_order_by_rating, -> { joins(:rates).group('movie_id').order('AVG(rates.rating) DESC') }

  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :posters, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }

  has_many :casts , dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :favourite_movies

  def first_poster
    posters.first
  end

  def movie_cast
    self.actors.pluck(:name).join(', ')
  end

  def get_average
    self.rates.present? ? self.rates.average(:rating) : 0
  end

  def get_ratings(user)
    user.rates.for_movie(self).first || user.rates.build(movie: self)
  end

  def self.get_movies_type(param)
    if param == LATEST
      self.latest_movies
    elsif param == FEATURED
      self.featured_movies
    elsif param == TOP_RATED
      self.movie_order_by_rating
    else
      self.all
    end
  end

  def added_to_favorites_by?(user_id)
    FavouriteMovie.exists?(user_id: user_id, movie_id: self.id)
  end

end
