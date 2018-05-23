class Admin::ReviewsController < Admin::BaseController
  def destroy
    organization = Organization.find(params[:organization_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to organization_path(organization)
  end
end