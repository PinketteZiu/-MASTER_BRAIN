class Brain < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
