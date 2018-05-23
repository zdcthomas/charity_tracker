require 'rails_helper'

describe "A visitor", type: :feature do
  context 'visits the root adress' do
    describe 'displayed information' do
      it 'should display a sign up and a login button' do
        visit root_path

        expect(page).to have_link("Login")
        expect(page).to have_link("Sign Up")
      end
      it 'should display the top organization with a button that leads to the organizations page' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        organization2 = Organization.create!(name:'another Charity', description:'does some stuff')
        organization3 = Organization.create!(name:'still yet another Charity', description:'does some more stuff')
        user = User.create!(username:'joe',password:'anthropist')
        review1 = user.reviews.create(score:3, text:'This one helped some', organization_id: organization1.id)
        review2 = user.reviews.create(score:4, text:'This one helped some more', organization_id: organization2.id)
        review3 = user.reviews.create(score:5, text:'This one helped way more', organization_id: organization3.id)

        visit root_path

        within('header') do
          expect(page).to have_content(organization3.name)
          expect(page).to have_content(organization3.description)
          expect(page).to have_link('Help')
        end
      end
      it 'should display a list of the top organizations in decending order' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        organization2 = Organization.create!(name:'another Charity', description:'does some stuff')
        organization3 = Organization.create!(name:'still yet another Charity', description:'does some more stuff')
        user = User.create!(username:'Phil',password:'anthropist')
        review1 = user.reviews.create(score:3, text:'This one helped some', organization_id: organization1.id)
        review2 = user.reviews.create(score:4, text:'This one helped some more', organization_id: organization2.id)
        review3 = user.reviews.create(score:5, text:'This one helped way more', organization_id: organization3.id)

        visit root_path
        within "content" do
          within "li:nth-child(1)" do
            expect(page).to have_content(organization3.name)
          end
          within "li:nth-child(2)" do
            expect(page).to have_content(organization2.name)
          end
          within "li:nth-child(3)" do
            expect(page).to have_content(organization1.name)
          end
        end
      end
      it 'should display a link to the organizations index' do
        visit root_path

        expect(page).to have_link('Organizations')
        click_on 'Organizations'

        expect(current_path).to eq(organizations_path)
      end
    end
    describe 'and clicks on the sign up button' do
      it 'should redirect to the sign up page' do
        visit root_path
        click_on 'Sign Up'

        expect(current_path).to eq(new_user_path)
      end
      it 'should display a form with fields for username and password' do
        visit root_path
        click_on 'Sign Up'

        expect(page).to have_field('user[username]')
        expect(page).to have_field('user[password]')
      end
      describe 'and fills out the form for signing up' do
        it 'should redirect to the root homepage if the information is valid' do
          visit root_path
          click_on 'Sign Up'

          username = 'davebob'
          password = 'password'
          fill_in 'user[username]', with: username
          fill_in 'user[password]', with: password

          click_on 'Submit'

          expect(current_path).to eq(root_path)
        end
      end
    end
  end
end
