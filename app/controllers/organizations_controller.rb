class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def show 
    @organization = Organization.find(params[:id])
    @average_score = @organization.average_score
    @review = Review.new
    @reviews = @organization.reviews.order("created_at DESC")
  end
end