require_relative 'user'
require_relative 'resource'
require_relative 'booking'
require_relative 'errors'
require_relative 'constants'
require_relative 'booking_manager'


puts "===CLI Lab Booking System Demo ~ first try adding the Extensions ==="

manager = BookingManager.new

student=User.new(id: 1, name:"Mahi", role: LabBooking::ROLE[:student])
assistant=User.new(id: 2, name:"Alex", role:LabBooking::ROLE[:assistant])
admin=User.new(id: 3, name:"Admin", role:LabBooking::ROLE[:admin])

microscope = Resource.new(id: 1, name:"Microscope",category: "lab")
projector = Resource.new(id: 2, name:"Projector",category: "Media")

all_resource=[microscope, projector]

puts "users and resources created"

booking1 = manager.create_booking(student, microscope)
puts"Booking created for #{booking1.user.name} to get #{booking1.resource.name}"

booking2 = manager.create_booking(assistant, projector)
puts"Booking created for #{booking2.user.name} to get #{booking2.resource.name}"

puts "\nActive bookings(#{manager.active_booking.size}):"
manager.active_booking.each do |b|
  puts " #{b.user.name} has #{b.resource.name} booked."
end

puts "\nAvailable resources:"
manager.available_resources(all_resource).each do |r|
  puts  " #{r.name}"
end

booking1.cancel
puts "Booking cancelled"

puts "\nAfter cancellation"
puts "Does resource include Microscope? #{microscope.available? ? "YES" : "NO"}"

puts "\n Demo is done"