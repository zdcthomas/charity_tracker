require 'rails_helper'

RSpec.feature "Donations", type: :feature do
  describe 'A user visiting the new donation page' do
    it 'should redirect to the my donations page with the new donations on the page' do
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
      
      amount = 200
      
      fill_in :Amount, with: amount
      click_on 'Donate'

      expect(current_path).to eq(user_path user)
      expect(page).to have_content("Donated #{amount} To #{organization1.name}")
    end
  end
end
