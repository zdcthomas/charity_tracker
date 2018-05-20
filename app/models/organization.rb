class Organization < ApplicationRecord
  has_many :reviews
  has_many :donations
  validates :name, :description, presence: true
end
