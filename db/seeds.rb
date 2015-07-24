# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(klk kkl lkk).each do |name|
  email = "#{name}@#{name}.com"
  next if User.exists? email: email
    # if I've already created the user (if User exists with the email address 'email'), skip to the next one
  User.create!(email: email, password: 'abc123', password_confirmation: 'abc123')
end
