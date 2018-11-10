# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
groups = 5.times.to_enum.map { |i| Group.create name: "Group #{i}"}

groups.each_with_index do |group, index|
  2.times.to_enum.with_index(index * 2 + 1) do |_, i|
    group.users.create({name: "User #{i}" })
 end
end
