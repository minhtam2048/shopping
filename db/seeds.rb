# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "admin",
    email: "admin@gmail.com",
    password:              "123456",
    password_confirmation: "123456",
    role: 1)

30.times do |n|
        name  = Faker::Name.name
        email = "example#{n+1}@gmail.com"
        password = "Luongminhtam123"
        User.create!(name:  name,
                     email: email,
                     password:              password,
                     password_confirmation: password,
                     role: 2)
end    



Category.create! id: 1, name: "Dog"
Category.create! id: 2, name: "Cat"
Category.create! id: 3, name: "House tool"
Category.create! id: 4, name: "Toy"
Category.create! id: 5, name: "Board game"

OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"


Category
categories = ["Textbook","Novel", "Pet","History", "House tool", "Politic", "Car", "Computer", "Toy", "Board Game"]
categories.each do |category|
	Category.create!(name: category)
end