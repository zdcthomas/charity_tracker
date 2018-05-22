require 'rails_helper'

describe "A visitor", type: :feature do
  describe 'visiting the organization show page' do
    it 'should display the name and description of the organization' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')

      visit organization_path organization1
      expect(page).to have_content(organization1.name)
      expect(page).to have_content(organization1.description)
    end
    it 'should have a donation button' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')

      visit organization_path organization1

      expect(page).to have_link('Donate')
    end
    describe 'and clicking on the the donate link' do
      it 'should redirect to the sign up page if the visitor is unauthenticated' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')

        visit organization_path organization1
        click_on 'Donate'

        expect(current_path).to eq(new_user_path)
      end
      it 'should redirect to the make a dontation page if the user is signed in' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        username ='django'
        password = 'silentD'
        user = User.create!(username:username, password:password)
        visit(login_path)
      
        fill_in :username, with: username
        fill_in :password, with: password
        click_on "Log In"

        visit organization_path organization1
        click_on 'Donate'

        expect(current_path).to eq(new_organization_donation_path organization1)
      end
    end
  end
end
