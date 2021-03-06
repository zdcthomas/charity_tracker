require 'rails_helper'
describe 'an Admin' do
  context 'on the show page for an organization' do
    it 'should have an edit and delete button' do
      organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
      admin = User.create!(username:'BigAdmin', password:'123abc', role:1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit organization_path(organization1)

      expect(page).to have_link("Edit This Organization")
      expect(page).to have_link("Delete This Organization")
    end
    context 'clicking on the edit button' do
      it 'should redirect to the organization edit page' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        admin = User.create!(username:'BigAdmin', password:'123abc', role:1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit organization_path(organization1)
        click_on("Edit This Organization")

        expect(current_path).to eq(edit_admin_organization_path(organization1))
      end
      it 'should change the data about that organization' do
        organization1 = Organization.create!(name:'Some Charity', description:'does some stuff')
        admin = User.create!(username:'BigAdmin', password:'123abc', role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit edit_admin_organization_path(organization1)


        description = "this is an edited description"
        old_description = organization1.description
        fill_in :organization_description, with: description
        click_on 'Update Organization'

        expect(current_path).to eq(organization_path(organization1))
        expect(page).to have_content(description)
        expect(page).to_not have_content(old_description)
      end
    end
    context 'clicking on the delete button' do
      it 'should delete that organization and redirect to organization index' do
        name = 'Some Charity'
        description = 'does some stuff'
        organization1 = Organization.create!(name: name, description:description)
        admin = User.create!(username:'BigAdmin', password:'123abc', role:1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit organization_path(organization1)

        click_on "Delete This Organization"

        expect(current_path).to eq(organizations_path)
        expect(page).to_not have_content(name)
        expect(page).to_not have_content(description)
      end
    end
    context 'reviews for an organization' do
      it 'should have a delete this review button for admins' do
        name = 'Some Charity'
        description = 'does some stuff'
        user = User.create!(username:'user', password:'password')
        organization1 = Organization.create!(name: name, description:description)
        review = user.reviews.create!(score:5, text:'this is great', organization_id: organization1.id)
        admin = User.create!(username:'BigAdmin', password:'123abc', role:1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit organization_path(organization1)
        click_on("Delete this Review")
        
        expect(current_path).to eq(organization_path(organization1))
        expect(page).to_not have_content(review.text)
      end
    end
  end
end