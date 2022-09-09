# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
["seller", "buyer"].each do |role|
  Role.find_or_create_by(name: role)
end
{devnTech: 0.3, Pak14: 0.5,defenceday: 0.4,myapp: 0.6,AzadiSale: 0.45 }.each do |hash, key|
  Coupen.find_or_create_by(coupen_code: hash, discount: key)
end
