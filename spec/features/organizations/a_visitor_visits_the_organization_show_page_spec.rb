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

      visit organization_path organization1

      expect(page).to have_content("Average User Score: 10")
    end
    it 'should display the reviews which users have given the organization with the most recent at the top' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
      user1 = User.create!(username:'django', password:'silentD')
      user2 = User.create!(username:'reinhardt', password:'jazzy')
      user3 = User.create!(username:'twofinger', password:'rein')
      review1 = user1.reviews.create!(score: 5, text:'some text', organization_id: organization1.id)
      review2 = user2.reviews.create!(score: 15, text:'some other text', organization_id: organization1.id)
      review3 = user3.reviews.create!(score: 12, text:'more review text', organization_id: organization1.id)

      visit organization_path organization1
      within "content" do
        within('li:nth-child(1)') do
          expect(page).to have_content("#{user3.username}: #{review3.text}")
        end
        within('li:nth-child(2)') do
          expect(page).to have_content("#{user2.username}: #{review2.text}")
        end
        within('li:nth-child(3)') do
          expect(page).to have_content("#{user1.username}: #{review1.text}")
        end
      end
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
        expect(page).to have_content("You must make an account to donate")
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
