class Room < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :user

  validates :name, :description, :price, presence: true
end
