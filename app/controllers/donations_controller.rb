class DonationsController < ApplicationController
  def new
    @donation = Donation.new
    @organization = Organization.find(params[:organization_id])
  end
  def create
    organization = Organization.find(params[:organization_id])
    @donation = organization.donations.new(amount:params[:donation][:amount], user_id:current_user.id)
    if @donation.save
      redirect_to user_path current_user
    else
      redirect_to new_organization_donation_path
    end
  end
end
