class Movie < ActiveRecord::Base

  PER_PAGE = 8
  LATEST = 'latest'
  FEATURED = 'featured'
  TOP_RATED = 'top_rated'
  OPTIONS = %w(Thriller Comedy Romance Action Crime)

  validates :title, presence: true, uniqueness: true, length: { maximum: 35 }
  validates :trailer, presence: true
  validates :description, presence: true
  validates :posters, presence: true
  validates :genre, presence: true

  scope :featured_movie, -> { where(featured: true) }
  scope :approved_movie, -> { where(approved: true) }
  scope :latest_movie, -> { order("release_date DESC") }
  scope :movie_order_by_rating, -> { joins(:rates).group('movie_id').order('AVG(rates.rating) DESC') }

  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :posters, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }

  has_many :casts , dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

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
      latest_movie.approved_movie
    elsif param == FEATURED
      featured_movie.approved_movie
    elsif param == TOP_RATED
      movie_order_by_rating.approved_movie
    else
      all.approved_movie
    end
  end

  def self.search_movies(params)
    if params[:type].present? || (params[:title].nil? && params[:genre].nil? && params[:actors].nil? && params[:start_date].nil?)
      get_movies_type(params[:type])
    else
      condition =  {
                      conditions: {},
                      with: {},
                      order: 'release_date DESC',
                      per_page: 8,
                      page: params[:page]
                    }
      condition[:conditions][:title] = params[:title] if params[:title].present?
      condition[:conditions][:genre] = params[:genre] if params[:genre].present?
      condition[:conditions][:actors] = params[:actors] if params[:actors].present?
      condition[:with][:release_date] = date_range(params[:start_date],params[:end_date]) if params[:start_date].present?
      condition[:with][:approved] = true

      search params[:search], condition
    end
  end

  def self.date_range(start_date, end_date)
    if start_date.present? && end_date.present?
      Date.parse(start_date)..Date.parse(end_date)
    elsif start_date.present?
      Date.parse(start_date)..Date.today
    end
  end

  def added_to_favorites_by?(user_id)
    FavouriteMovie.exists?(user_id: user_id, movie_id: self.id)
  end

  def searched_movie
    {
      movie: self.as_json,
      actors: self.actors.as_json,
      reviews: self.reviews.as_json,
      rating: self.rates.as_json
    }
  end

end
