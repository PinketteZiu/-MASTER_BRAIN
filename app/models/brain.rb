class Brain < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  VALID_COMPETENCES = %w[Analyse Créativité Logique Mémoire Communication Apprentissage Gestion_émotionnelle]

  validates :competence, inclusion: { in: VALID_COMPETENCES,
    message: "%{value} n'est pas une compétence valide" }
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
