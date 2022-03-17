# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

titanic = Medium.create! title: "Titanic", medium_type: Medium.medium_types[:movie]
green_mile = Medium.create! title: "La Ligne Verte", medium_type: Medium.medium_types[:movie]

donovan = User.create! first_name: "Donovan", last_name: "Benfouzari", email: "d.benfouzari@gmail.com"
oceane = User.create! first_name: "Océane", last_name: "Crispyn", email: "crispyn.oceane@gmail.com"

donovan.share green_mile
oceane.share titanic
