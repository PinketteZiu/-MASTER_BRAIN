class User < ApplicationRecord
  has_many :brains, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :offers, through: :brains, source: :bookings

  # ATTENTION REMETTRE HAS_ONE A LA FIN

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
