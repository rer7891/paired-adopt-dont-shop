# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create!(name: 'Denver Pet Shelter',
                           address: '123 Colfax Ave',
                           city: 'Denver',
                           state: 'CO',
                           zip_code: '80004')

shelter_2 = Shelter.create!(name: 'Colorado Magical Creatures Rescue',
                            address: '777 Colorado Blvd',
                            city: 'Denver',
                            state: 'CO',
                            zip_code: '80012')

shelter_1.pets.create!(image_url: 'https://media.wired.com/photos/5dd593a829b9c40008b179b3/master/w_2560%2Cc_limit/Cul-BabyYoda_mandalorian-thechild-1_af408bfd.jpg',
                       name: 'Baby Yoda',
                       description: 'I am an adorable one strong with the Force. Enjoys eating frogs.',
                       approximate_age: 50,
                       sex: 'M',
                       )
shelter_1.pets.create!(image_url: 'https://cdn3.movieweb.com/i/article/HIxWc8aYAdMq5IYlYo0YPjfnqpUYfh/798:75/Gremlins-Movie-1984-Gizmo-Original-Villain.jpg',
                        name: 'Gizmo',
                        description: 'I am a very fluffy, kind Mogwai. Do not place near water.',
                        approximate_age: 2,
                        sex: 'M',
                      )
shelter_2.pets.create!(image_url: 'https://img1.looper.com/img/gallery/the-untold-truth-of-baby-groot/-1495639424.jpg',
                        name: 'Grooty',
                        description: 'I am a lovable, high-energy Flora Colossus. My ideal home will dedicate more time to help me learn how to press buttons.',
                        approximate_age: 1,
                        sex: 'F',
                        )
