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
      it 'should redirect to the make a dontation page' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')

        visit organization_path organization1
        click_on 'Donate'

        expect(current_path).to eq(new_organization_donation_path organization1)
      end
    end
  end
end
