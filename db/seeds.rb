# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.destroy_all
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end
100.times do |i|
  Cat.create!(birth_date: time_rand,
  name: "cat_#{i}",
  color: Cat::COLORS.sample,
  sex: Cat::SEXES.sample,
  description: "description #{i}"
  )
end
