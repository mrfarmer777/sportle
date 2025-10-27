# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

teams = JSON.parse(File.read('db/seed_data/teams.json'))['teams']
teams.map { |team_data|
  Team.find_or_create_by!(
    name: team_data['name'],
    stats_api_id: team_data['id']
  )
}