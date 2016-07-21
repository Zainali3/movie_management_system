class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  has_many :report_reviews, dependent: :destroy
  validates :review, presence: true,
                    length: { minimum: 5 }

  def reported_by?(user_id)
    self.report_reviews.where(user_id: user_id).present?
  end
end
