require 'rails_helper'

RSpec.describe Donation, type: :model do
  it {should belong_to(:user)}
  it {should belong_to(:organization)}
  it {should validate_presence_of(:amount)}
end
