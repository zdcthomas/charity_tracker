require 'rails_helper'

describe "A visitor", type: :feature do
  describe 'visiting the organization show page' do
    it 'should display the name and description of the organization' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')

      visit organization_path organization1

      expect(page).to have_content(organization1.name)
      expect(page).to have_content(organization1.description)
    end
    it 'should display the average score for the organization' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
      user1 = User.create!(username:'django', password:'silentD')
      user2 = User.create!(username:'reinhardt', password:'jazzy')
      user3 = User.create!(username:'twofinger', password:'rein')
      review1 = user1.reviews.create!(score: 5, text:'some text', organization_id: organization1.id)
      review2 = user2.reviews.create!(score: 15, text:'some other text', organization_id: organization1.id)
      review3 = user3.reviews.create!(score: 12, text:'more review text', organization_id: organization1.id)

      visit organization_path organization1

      within('.reviews') do
        expect(page).to have_content("#{user1.name}: #{review1.text}")
        expect(page).to have_content("#{user2.name}: #{review2.text}")
        expect(page).to have_content("#{user3.name}: #{review4.text}")
      end
    end
    it 'should display the reviews which users have given the organization' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
      user = User.create!(username:'django', password:'silentD')
      user.reviews.create!(score: 5, text:'some text', organization_id: organization1.id)
      user.reviews.create!(score: 15, text:'some text', organization_id: organization1.id)
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
