class Brain < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name_competence_and_address,
  against: [:name, :competence, :address],
  using: {
    tsearch: { prefix: true }
  }
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
  # validates :latitude, presence: true, numericality: true
  # validates :longitude, presence: true, numericality: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  scope :nearby, ->(latitude, longitude, distance_in_km = 150 ) {
    near([latitude, longitude], distance_in_km, units: :km)
  }

  def self.search(query)
    brains = search_by_name_competence_and_address(query)
    if brains.empty?
      geocoded_result = Geocoder.search(query).first
      if geocoded_result
        latitude = geocoded_result.latitude
        longitude = geocoded_result.longitude
        brains = nearby(latitude, longitude)
      end
    end
    brains
  end

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
