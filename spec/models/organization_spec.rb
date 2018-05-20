require 'rails_helper'

RSpec.describe Organization, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews)}
  it {should have_many(:donations)}
end
