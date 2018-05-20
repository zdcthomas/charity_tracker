class Organization < ApplicationRecord
  has_many :reviews
  has_many :donations
  validates :name, :description, presence: true

  def average_score
    self.reviews.average(:score).to_f.round(1)
  end

  def self.top_orgs
    Organization.all.sort_by do |org|
      org.average_score
    end.reverse
  end

end
