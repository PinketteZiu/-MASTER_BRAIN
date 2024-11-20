class Brain < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :bookings, dependent: :destroy

  # validate :acceptable_image

  VALID_COMPETENCES = %w[Analyse Créativité Logique Mémoire Communication Apprentissage Gestion_émotionnelle]

  validates :competence, inclusion: { in: VALID_COMPETENCES,
    message: "%{value} n'est pas une compétence valide" }
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true

  private

  def acceptable_image
    return unless image.attached?

    unless image.byte_size <= 1.megabyte
      errors.add(:image, "est trop volumineuse (maximum 1 Mo).")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "doit être un JPEG ou un PNG.")
    end
  end
end
