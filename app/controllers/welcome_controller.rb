class WelcomeController < ApplicationController
  def index
    @top_orgs = Organization.top_orgs
  end
end
