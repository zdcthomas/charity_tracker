require 'rails_helper'
describe 'A User' do
  context 'visiting the organizations page' do
    it 'should take users to the donate page after they click on the donate buton' do
      user = User.create!(username:'jim', password:'bob')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
      
      visit organizations_path
      click_on('Donate')

      expect(current_path).to eq(new_organization_donation_path organization1)
    end
  end
end

describe 'A Visitor' do
  context 'visiting the organizations page' do
    it 'should display all the organizations with their descriptions and  average score' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
      organization2 = Organization.create!(name:'Another Charity', description:'does some more stuff')
      organization3 = Organization.create!(name:'one more organization', description:'does some compeltely different stuff')

      visit organizations_path

      expect(page).to have_content(organization1.name)
      expect(page).to have_content(organization2.name)
      expect(page).to have_content(organization3.name)
      expect(page).to have_content(organization1.description)
      expect(page).to have_content(organization2.description)
      expect(page).to have_content(organization3.description)
    end
    it 'should redirect ot the sign up page if the visitor tries to donate' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')

      visit organizations_path

      click_on('Donate')

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("You must make an account to donate")
    end
    context 'each organization name' do
      it'should be a link to that organizations page' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        visit organizations_path

        click_on(organization1.name)
        expect(current_path).to eq(organization_path(organization1))
      end
    end
  end
end
