require 'rails_helper'

RSpec.feature "My Profile", type: :feature do
  describe 'A User' do
    context 'visiting the user show page' do 
      it 'should display the users username' do
        username = 'Igor'
        password = 'S7rav1nSk1'
        user = User.create!(username: username, password: password)

        visit user_path user

        expect(page).to have_content(username)
      end
      it 'should display the donations the user has made' do
        username = 'Igor'
        password = 'S7rav1nSk1'
        user = User.create!(username: username, password: password)
        organization1 = Organization.create!(name:'RED CROSS', description:'american relief aid')
        donation1 = user.donations.create!(amount: 40, organization_id: organization1.id)
        donation2 = user.donations.create!(amount: 200, organization_id: organization1.id)

        visit user_path user

        within('.donations') do
          expect(page).to have_content("Donated #{donation1.amount} to #{organization1.name}")
          expect(page).to have_content("Donated #{donation2.amount} to #{organization1.name}")
        end
      end
      it 'should display the reviews the user has left' do
        username = 'Igor'
        password = 'S7rav1nSk1'
        user = User.create!(username: username, password: password)
        organization1 = Organization.create!(name:'RED CROSS', description:'american relief aid')
        review1 = user.reviews.create!(score: 5, 
                                       text: 'After I donated, I saw a huge improvement in the local area!',
                                       organization_id: organization1.id)
        review2 = user.reviews.create!(score: 2, 
                                       text: 'I saw no difference!',
                                       organization_id: organization1.id)
        visit user_path user

        within('.reviews') do
          expect(page).to have_content("#{organization1.name}")
          expect(page).to have_content("Score: #{review1.score}")
          expect(page).to have_content("#{review1.text}")
          expect(page).to have_content("Score: #{review2.score}")
          expect(page).to have_content("#{review2.text}")
        end
      end
    end
  end
end