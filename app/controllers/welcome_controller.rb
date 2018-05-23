class WelcomeController < ApplicationController
  def index
    @top_orgs = Organization.top_orgs[0...9]
    @top_organization = @top_orgs.first
  end
end
