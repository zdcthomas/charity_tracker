require 'rails_helper'

RSpec.describe Review, type: :model do
  it {should belong_to(:user)}
  it {should belong_to(:organization)}
  it {should validate_presence_of(:score)}
  it {should validate_presence_of(:text)}
end
