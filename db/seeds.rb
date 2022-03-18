# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

titanic = Medium.create! title: 'Titanic', medium_type: Medium.medium_types[:movie]
green_mile = Medium.create! title: 'La Ligne Verte', medium_type: Medium.medium_types[:movie]

donovan = User.create! first_name: 'Donovan', last_name: 'Benfouzari',
                       email: 'd.benfouzari@gmail.com'
oceane = User.create! first_name: 'Océane', last_name: 'Crispyn', email: 'crispyn.oceane@gmail.com'

share_green_mile = Share.create! medium: green_mile, user: donovan
share_titanic = Share.create! medium: titanic, user: oceane

Comment.create! author: oceane, commentable: share_green_mile, body: 'Great movie!'
Comment.create! author: donovan, commentable: share_titanic, body: 'Already seen 1000 times...'
