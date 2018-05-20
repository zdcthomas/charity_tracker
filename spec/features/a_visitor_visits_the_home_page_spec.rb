require 'rails_helper'

describe "A visitor", type: :feature do
  context 'visits the root adress' do
    describe 'displayed information' do
      it 'should display a sign up and a login button' do
        visit root

        expect(page).to have_link("Login")
        expect(page).to have_link("Sign Up")
      end
      it 'should display a list of the top organizations in decending order' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        organization2 = Organization.create!(name:'another Charity', description:'does some stuff')
        organization3 = Organization.create!(name:'still yet another Charity', description:'does some more stuff')
        user = User.create!(username:'Phil',password:'anthropist')
        review1 = user.review.create(score:3, text:'This one helped some', organization_id: organization1.id)
        review2 = user.review.create(score:4, text:'This one helped some more', organization_id: organization2.id)
        review3 = user.review.create(score:5, text:'This one helped way more', organization_id: organization3.id)

        visit root

        within "li:nth-child(1)" do
          expect(page).to have_content(organization3.id)
        end
        within "li:nth-child(2)" do
          expect(page).to have_content(organization2.id)
        end
        within "li:nth-child(3)" do
          expect(page).to have_content(organization1.id)
        end
      end
    end
    describe 'and clicks on the sign up button' do
      it 'should redirect to the sign up page' do
        visit root
        click_on 'Sign Up'

        expect(current_path).to eq(new_user_path)
      end
      it 'should display a form with fields for username and password' do
        visit root
        click_on 'Sign Up'

        expect(page).to have_field('user[username]')
        expect(page).to have_field('user[password]')
      end
      describe 'and fills out the form for signing up' do
        it 'should redirect to the root homepage if the information is valid' do
          visit root
          click_on 'Sign Up'

          username = 'davebob'
          password = 'password'
          fill_in 'user[username]', with: username
          fill_in 'user[password]', with: password

          click_on 'Submit'

          expect(current_path).to eq(root)
        end
      end
    end
  end
end
