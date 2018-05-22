require 'rails_helper'
describe 'A User' do
  context 'clicking the log out button' do
    it 'should log the user out' do
      user = User.create!(username:'JFranco',password:'SethRogan')

      visit root_path
      click_link 'Login'
      fill_in :username, with: user.username
      fill_in :password, with: user.password
      click_on 'Log In'

      click_on 'Log Out'

      expect(page).to_not have_content('Log Out')
    end
  end
end