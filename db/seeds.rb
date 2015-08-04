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

# # Create profiles
# kristen_profile = Profile.create!(moniker: "KLK", location: "Boston, MA", email_or_phone: "phone", phone_number: 1234567890, selected_time: "evening")
# ken_profile = Profile.create!(moniker: "kpk", location: "Cambridge, MA", email_or_phone: "phone", phone_number: 2222222222, selected_time: "morning")
# courtney_profile = Profile.create!(moniker: "CGA", location: "Brookline, MA", email_or_phone: "email", selected_time: "afternoon")

# # Create messages



# ['Today\'s a great day!', 'The future belongs to those who believe in the beauty of their dreams. -Eleanor Roosevelt', 'Learned today that otters hold hands when they sleep so they don\'t float away from one another.', 'In Welsh folklore, corgis were the preferred method of transportation for fairies.'].each do |body|
#   body = body
#   next if Message.exists? body: body
#   Message.create!(body: body, password: 'abc123', password_confirmation: 'abc123')
# end


# itinerary = stephanie.itineraries.create!(name: 'Trip to Boston')
# itinerary.events.create!(title: 'Duck Tour', date: '06/07/2015', location: 'Long Wharf, Boston', start_time: '07:00', end_time: '08:00', attendees: 'Max, Joe, Steve', desc: 'Quinoa Pitchfork laborum do, deep v normcore pop-up quis Vice nesciunt dolore PBR ut. Fugiat chia commodo, fashion axe viral flannel lomo id banjo ea. Nesciunt ullamco church-key accusamus, fashion axe quinoa fingerstache wolf street art. Proident Marfa sustainable beard kogi slow-carb. YOLO duis nulla 8-bit Godard bicycle rights aliqua. Cliche quinoa consectetur, slow-carb pariatur tilde excepteur scenester Austin eu aute. Fugiat veniam anim duis id, salvia officia paleo selfies fingerstache non proident Odd Future fap master cleanse.', image: @file_one)
# itinerary.events.create!(title: 'Library Tour', date: '06/04/2015', location: 'Copley Square', start_time: '10:00', end_time: '11:00', attendees: 'Max, Joe, Steve', desc: 'Nesciunt skateboard occupy, distillery narwhal in ex deserunt exercitation. DIY lomo irony cronut, pour-over occaecat odio placeat flannel. In mustache VHS, +1 cronut flexitarian aesthetic selvage. Aliquip esse health goth Bushwick try-hard leggings banjo tousled anim, ullamco vegan artisan single-origin coffee typewriter DIY. Freegan tilde viral squid excepteur wayfarers laboris pariatur, duis ut cillum Helvetica. Consectetur pork belly Marfa, adipisicing jean shorts forage cupidatat. Meditation artisan nostrud distillery mumblecore meggings.', image: @file_two)

# puts "Stephanie Itinerary  and Events inserted"

