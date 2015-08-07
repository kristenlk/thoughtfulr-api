# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create users
%w(klk kpk cga).each do |name|
  email = "#{name}@#{name}.com"
  next if User.exists? email: email
  kristen = User.create!(email: 'klk@klk.com', password: 'abc123', password_confirmation: 'abc123')
  ken = User.create!(email: 'kpk@kpk.com', password: 'abc123', password_confirmation: 'abc123')
  courtney = User.create!(email: 'cga@cga.com', password: 'abc123', password_confirmation: 'abc123')
end

# Create profiles
kristen_profile = Profile.create!(moniker: "KLK", location: "Boston, MA", email_or_phone: "phone", phone_number: 2039066039, selected_time: "evening")
ken_profile = Profile.create!(moniker: "kpk", location: "Cambridge, MA", email_or_phone: "phone", phone_number: 2039066039, selected_time: "morning")
courtney_profile = Profile.create!(moniker: "CGA", location: "Brookline, MA", email_or_phone: "phone", phone_number: 2039066039, selected_time: "afternoon")

# Create messages
Message.create!(body: 'Today\'s a great day!', user_id: 1)
Message.create!(body: 'The future belongs to those who believe in the beauty of their dreams. -Eleanor Roosevelt', user_id: 2)
Message.create!(body: 'In Welsh folklore, corgis were the preferred method of transportation for fairies.', user_id: 3)

# Create received messages
# ReceivedMessage.create!(user_id: 1, message_id: 1)
# ReceivedMessage.create!(user_id: 2, message_id: 2)
