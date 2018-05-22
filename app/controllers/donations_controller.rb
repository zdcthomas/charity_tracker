class DonationsController < ApplicationController
  def new
    @donation = Donation.new
    @organization = Organization.find(params[:organization_id])
  end
  def create
  end
end
