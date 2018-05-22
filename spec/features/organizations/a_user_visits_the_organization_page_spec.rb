require 'rails_helper'

describe "A User", type: :feature do
  describe 'visiting the organization show page' do
    it 'should see a Review field with a score field and a submit button' do
      user = User.create!(username:'Say', password:'myname')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      organization1 = Organization.create!(name:'Red Cross', description:'does stuff for people stometimes')

      visit organization_path organization1

      expect(page).to have_field('review[text]')
      expect(page).to have_field('review[score]')
    end
    context 'after entering a review and clicking submit' do
      it 'should then display the review on the organization page' do
        user = User.create!(username:'Say', password:'myname')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        organization1 = Organization.create!(name:'Red Cross', description:'does stuff for people stometimes')

        visit organization_path organization1
        text = 'Some review text'
        score = 5
        fill_in :review_text, with: text
        fill_in :review_score, with: score
        click_on('Submit Review')

        expect(current_path).to eq(organization_path(organization1))

        expect(page).to have_content(text)
        expect(page).to have_content(score)
      end
      it 'should not save the review if it has no text' do
        user = User.create!(username:'Say', password:'myname')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        organization1 = Organization.create!(name:'Red Cross', description:'does stuff for people stometimes')

        visit organization_path organization1
        score = 5
        fill_in :review_score, with: score
        click_on('Submit Review')

        expect(page).to_not have_content(score)
      end
    end
  end
end