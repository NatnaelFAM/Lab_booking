require_relative 'user'
require_relative 'resource'
require_relative 'booking'
require_relative 'errors'


puts "===CLI Lab Booking System Demo==="

user1=User.new(id: 1, name:"Mahi", role:"Student")
user2=User.new(id: 2, name:"Alex", role:"Teacher")

microscope = Resource.new(id: 1, name:"Microscope",category: "lab")
projector = Resource.new(id: 2, name:"Projector",category: "lab")

puts "Created user and resource"

booking1 = Booking.new(user:user1, resource:microscope)
puts"Booking created for #{booking1.user.name} to get #{booking1.resource.name}"

booking1.cancel
puts "Booking cancelled"

puts "Resource available? #{microscope.available? ? "YES" : "NO"}"

puts "\n Demo is done"