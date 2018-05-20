require 'rails_helper'

describe "An unauthenticated user visits the homepage,", type: :feature do

  describe 'and clicking on the login button' do
    it 'should bring them to the login page' do
      visit root_path
      click_on'Login'

      expect(current_path).to eq(login_path)
    end
    it 'should have a login form' do
      visit login_path

      expect(page).to have_field("username")
      expect(page).to have_field("password")
    end

    describe 'and after filling out the form,' do

      it 'should bring them back to the home page' do
        visit login_path
        user = User.create!(username:'user1', password:'password')
        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        save_and_open_page
        click_on 'Log In'

        expect(current_path).to eq(root_path)

      end
      it 'should no longer show the login button' do
        visit login_path
        user = User.create!(username:'user1', password:'password')
        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_on 'Log In'

        expect(page).to_not have_content('Log In')
        expect(page).to_not have_content('Sign Up')
      end
      it 'should show a link to their profile page' do
        visit login_path
        user = User.create!(username:'user1', password:'password')
        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_on 'Log In'

        expect(page).to have_link("My Profile")
      end
    end
  end
end