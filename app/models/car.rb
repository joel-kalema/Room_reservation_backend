class room < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :user

  has_one_attached :pictures

  validates :name, :description, :price, presence: true
end
