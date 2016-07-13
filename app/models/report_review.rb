class ReportReview < ActiveRecord::Base

  belongs_to :user
  belongs_to :review

  after_create :report_count

  private

  def self.check_already_reported?(review_id,user_id)
   ReportReview.exists?(review_id: review_id, user_id: user_id)
  end

  def report_count
    review.report_count += 1
    review.save
  end

end
