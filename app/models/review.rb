class Review < ActiveRecord::Base
  belongs_to :movie
  validates :review, presence: true,
                    length: { minimum: 5 }
end
