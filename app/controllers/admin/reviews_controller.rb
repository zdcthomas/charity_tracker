class Admin::ReviewsController < Admin::BaseController
  def destroy
    require'pry';binding.pry
    organization = Organization.find(params[:organization_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to organization_path(organization)
  end
end