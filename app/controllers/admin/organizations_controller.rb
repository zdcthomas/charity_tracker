class Admin::OrganizationsController < Admin::BaseController
  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
    if @organization.save
      redirect_to organization_path @organization
    else
      redirect_to edit_admin_organization_path @organization
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_path
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :description)
  end
end