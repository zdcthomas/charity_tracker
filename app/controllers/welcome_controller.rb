class WelcomeController < ApplicationController
  def index
    @top_orgs = Organization.top_orgs
    @top_organization = @top_orgs.first
  end
end
