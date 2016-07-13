class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  has_many :report_reviews
  validates :review, presence: true,
                    length: { minimum: 5 }
end
