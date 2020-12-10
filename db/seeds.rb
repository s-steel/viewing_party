# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PartyGuest.destroy_all
Party.destroy_all 
Friendship.destroy_all
User.destroy_all

fake, user, example = User.create(
            [
              {
                email: 'fake_user@example.com', 
                password: 'fake_user', 
                password_confirmation: 'fake_user'
              },
              {
                email: 'user@example.com', 
                password: 'user', 
                password_confirmation: 'user'
              },
              {
                email: 'example_user@example.com', 
                password: 'example_user', 
                password_confirmation: 'example_user'
              }
            ]
          )

fake.followed << [user, example]
fake.followers << [user, example]
example.followed << [user]
example.followers << [user]

party, exclusive_party = Party.create(
                                      [
                                        {
                                          movie_id: 121,
                                          duration: 179,
                                          when: DateTime.now,
                                          host_id: fake.id 
                                        },
                                        {
                                          movie_id: 5966,
                                          duration: 90,
                                          when: DateTime.now,
                                          host_id: example.id
                                        }
                                      ]
                                    )

party.guests << [user, example]
exclusive_party.guests << user 
