class Brain < ApplicationRecord
  belongs_to :user
  has_many :bookings
  belongs_to :user
end
