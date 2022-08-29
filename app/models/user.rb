class User < ApplicationRecord
  has_secure_password

  has_many :reservations, dependent: :delete_all
  has_many :rooms, dependent: :delete_all

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
