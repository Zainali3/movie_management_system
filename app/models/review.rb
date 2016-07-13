class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  validates :review, presence: true,
                    length: { minimum: 5 }
end
