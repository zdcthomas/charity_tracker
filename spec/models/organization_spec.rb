require 'rails_helper'

RSpec.describe Organization, type: :model do
  it {should validate(:name)}
  it {should validate(:description)}  
end
