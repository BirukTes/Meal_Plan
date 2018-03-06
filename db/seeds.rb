# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# exit if !Rails.env.development?, positive is more preferable with accordance to Rails style guide
exit unless Rails.env.development?

puts 'Delete the Data'
Recipe.delete_all
User.delete_all

puts 'Creating User'
user = FactoryGirl.create(:user, email: 'test@example.com')

puts 'Creating Recipes'
20.times do
  FactoryGirl.create(:recipe, user: user)
end
