require 'rails_helper'

RSpec.describe Organization, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews)}
  it {should have_many(:donations)}
  describe 'class method' do
    describe 'top_orgs' do
      it 'should return the organizations ordered descending by average score' do
        organization1 = Organization.create!(name: 'Some Charity', 
                                             description: 'does some stuff')
        organization2 = Organization.create!(name: 'another Charity',
                                             description: 'does some stuff')
        organization3 = Organization.create!(name: 'still yet another Charity',
                                             description: 'does some more stuff')
        user = User.create!(username: 'Phil', password: 'anthropist')

        user.reviews.create(score: 3,
                            text: 'This one helped some', 
                            organization_id: organization1.id)
        user.reviews.create(score: 10,
                            text: 'I really like this one', 
                            organization_id: organization1.id)
        user.reviews.create(score: 4,
                            text: 'This one helped some more', 
                            organization_id: organization2.id)
        user.reviews.create(score: 5,
                            text: 'This one helped way more', 
                            organization_id: organization3.id)

        top_orgs = Organization.top_orgs
        expect(top_orgs.first).to eq(organization1)
        expect(top_orgs[1]).to eq(organization3)
        expect(top_orgs.last).to eq(organization2)
      end
    end
  end
  describe 'instance method' do
    describe 'average score' do
      it 'should return the average user score for an organization' do
        organization = Organization.create!(name:'Some Charity', 
                                             description:'does some stuff')
        user = User.create!(username: 'Phil',
                            password: 'anthropist')
        user.reviews.create(score: 3,
                            text: 'This one helped a bit',
                            organization_id: organization.id)
        user.reviews.create(score: 10,
                            text: 'I really like this one',
                            organization_id: organization.id)
        user.reviews.create(score: 4,
                            text: 'This one helped some more',
                            organization_id: organization.id)

        expect(organization.average_score).to eq(5.7)
      end
    end
  end
end
