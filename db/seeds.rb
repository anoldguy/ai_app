# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create sample players
sample_players = [
  { name: "Alex Johnson", birthdate: 25.years.ago.to_date },
  { name: "Sarah Williams", birthdate: 28.years.ago.to_date },
  { name: "Michael Brown", birthdate: 22.years.ago.to_date },
  { name: "Emma Davis", birthdate: 30.years.ago.to_date },
  { name: "James Wilson", birthdate: 27.years.ago.to_date }
]

sample_players.each do |player_attrs|
  Player.find_or_create_by!(name: player_attrs[:name]) do |player|
    player.birthdate = player_attrs[:birthdate]
  end
end

puts "Created #{Player.count} players"

# Create a test user
User.find_or_create_by!(email_address: "test@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

puts "Created test user: test@example.com (password: password)"
