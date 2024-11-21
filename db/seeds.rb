# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
VALID_COMPETENCES = %w[Analyse Créativité Logique Mémoire Communication Apprentissage Gestion_émotionnelle]
PHRASES = [
  "Analyse approfondie des données",
  "Créativité et innovation",
  "Logique et résolution de problèmes",
  "Mémoire exceptionnelle",
  "Communication efficace",
  "Apprentissage rapide",
  "Gestion émotionnelle",
  "Travail d'équipe",
  "Leadership inspirant",
  "Adaptabilité et flexibilité",
  "Gestion du temps",
  "Prise de décision stratégique",
  "Compétences interpersonnelles",
  "Pensée critique",
  "Résolution de conflits",
  "Compétences en négociation",
  "Gestion de projet",
  "Compétences techniques",
  "Esprit d'initiative",
  "Orientation client",
  "Gestion du stress",
  "Développement web",
  "Programmation en Ruby on Rails",
  "Développement d'applications mobiles",
  "Programmation en JavaScript",
  "Conception de bases de données",
  "Développement d'API",
  "Programmation en Python",
  "Programmation en Java",
  "Programmation en C++",
  "Programmation en PHP",
  "Programmation en Swift",
  "Programmation en Kotlin",
  "Programmation en Go",
  "Programmation en Rust",
  "Programmation en TypeScript",
  "Développement front-end",
  "Développement back-end",
  "Développement full-stack",
  "Gestion de versions avec Git",
  "Intégration continue et déploiement continu (CI/CD)"
]
20.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Name.name)
end

100.times do
  latitude = rand(42..50)
  longitude = rand(0..9)
  geocoded_result = Geocoder.search([latitude, longitude]).first
  if geocoded_result
    address = geocoded_result.address
    Brain.create!(
      name: PHRASES.sample,
      price: Faker::Number.number(digits: 2),
      address: address,
      latitude: latitude,
      longitude: longitude,
      user: User.all.sample,
      competence: VALID_COMPETENCES.sample
    )
  end
end

50.times do
  Booking.create!(confirmation: false, user: User.all.sample, brain: Brain.all.sample, start_date: Faker::Date.forward(days: 15), end_date: Faker::Date.forward(days: 30))
end
