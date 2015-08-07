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
kristen_profile = Profile.create!(moniker: "KLK", location: "Boston, MA", email_or_phone: "phone", phone_number: 2039066039, selected_time: "evening", user_id: 1)
ken_profile = Profile.create!(moniker: "kpk", location: "Cambridge, MA", email_or_phone: "phone", phone_number: 2039066039, selected_time: "morning", user_id: 2)
courtney_profile = Profile.create!(moniker: "CGA", location: "Brookline, MA", email_or_phone: "phone", phone_number: 2039066039, selected_time: "afternoon", user_id: 3)

# Create messages
Message.create!(body: 'At this exact moment, there are probably tens of thousands of babies laughing around the world.', user_id: 1)
Message.create!(body: 'Sea horses mate for life and travel holding each other\'s tails.', user_id: 2)
Message.create!(body: 'In Welsh folklore, corgis were the preferred method of transportation for fairies.', user_id: 3)
Message.create!(body: 'Male puppies will sometimes let female puppies win when they play-fight so they can get to know them better.', user_id: 1)
Message.create!(body: 'Dolphins have names for one another.', user_id: 2)
Message.create!(body: 'Otters hold hands when they are asleep so that they don\'t float away from each other.', user_id: 3)

# Create received messages
# ReceivedMessage.create!(user_id: 1, message_id: 1)
# ReceivedMessage.create!(user_id: 2, message_id: 2)
