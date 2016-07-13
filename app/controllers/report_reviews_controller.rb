class ReportReviewsController < ApplicationController

  before_action :get_review

  def create
    unless ReportReview.check_already_reported?(params[:review_id],current_user.id)
      @reported = @review.report_reviews.new
      @reported.user = current_user
      @reported.save
    end
  end

  private

    def get_review
      @review = Review.find(params[:review_id])
    end
end
