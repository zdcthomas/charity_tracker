class ReviewsController < ApplicationController
  def create
    organization = Organization.find(params[:organization_id])
    review = organization.reviews.new(score:params[:review][:score], text:params[:review][:text], user_id: current_user.id)
    if review.save
      redirect_to organization_path organization
    else
      redirect_to organization_path organization
    end
  end
end
