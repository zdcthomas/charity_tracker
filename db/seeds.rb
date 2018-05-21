# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ORGANIZATIONS = ["American Red Cross", "Wounded Warrior", "Save the Children", "World Wildlife Federation", "International Rescue Commitee"]
REVIEWS = ['another charitable organization that isnt that great', 'this one isnt great', 'a good review', 'a great review']
USERS = ['JimBob', 'anotheruser', 'username', 'joe', 'aPlant']
DESCRIPTIONS = ['An organization description', 'some other description', 'focuses on things overseas']

ORGANIZATIONS.each do |organization|
  Organization.create!(name:organization,
                       description:DESCRIPTIONS.sample)
end

USERS.each do |name|
  user = User.create!(username:name,
                      password:'blah')
  2.times do |num|
    user.reviews.create!(score:num = rand(5),
                         text:REVIEWS.sample,
                         organization_id:Organization.all.sample.id,
                         )
  end
  3.times do |num|
    user.donations.create!(organization_id:Organization.all.sample.id,
                           amount:num+rand(100))
    end
end
