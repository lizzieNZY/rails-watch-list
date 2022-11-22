# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Deleting previous #{Movie.count} movie(s)"
Movie.destroy_all
puts "Finished deleting"

puts "Adding new movies"

movies = JSON.parse(URI.open("http://tmdb.lewagon.com/movie/top_rated").read)
movies = movies["results"]

10.times do
  data = movies.sample
  movie = Movie.new
  movie.title = data["title"]
  movie.overview = data["overview"]
  movie.poster_url = "https://image.tmdb.org/t/p/w500" + data["poster_path"]
  movie.rating = data["vote_average"]
  movie.save!

  puts "Adding #{movie.id} - #{movie.title}"
end

puts "Finished adding, #{Movie.count} movie(s) have been added."
