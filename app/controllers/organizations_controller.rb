class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 5)
  end

  def show 
    @organization = Organization.find(params[:id])
    @average_score = @organization.average_score
    @review = Review.new
    @reviews = @organization.reviews.order("created_at DESC")
  end
end