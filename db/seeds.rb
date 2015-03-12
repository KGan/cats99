# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

num_users = 30

num_users.times do |i|
  User.create!(
  user_name: "user_#{i+1}",
  password: "password"
  )
end

100.times do |i|
  Cat.create!(birth_date: time_rand,
  name: "cat_#{i+1}",
  color: Cat::COLORS.sample,
  sex: Cat::SEXES.sample,
  description: "description #{i}",
  user_id: rand(num_users) + 1
  )
end

Cat.all.each do |cat|
  sd = time_rand
  cat.cat_rental_requests.create!(
    :user_id => rand(num_users) + 1,
    start_date: sd,
    end_date: Time.at(sd.to_f + time_rand.to_f)
  )
end
