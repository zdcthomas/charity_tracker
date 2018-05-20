class Review < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  validates :score, :text, presence: true
end
