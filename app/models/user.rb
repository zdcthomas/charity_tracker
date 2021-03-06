class User < ApplicationRecord
  has_secure_password
  
  has_many :reviews
  has_many :donations

  validates :username, presence: true, uniqueness: true

  enum role: [:default, :admin]
end
