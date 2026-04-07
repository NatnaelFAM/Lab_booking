require_relative 'user'
require_relative 'resource'
require_relative 'booking'
require_relative 'booking_manager'
require_relative 'errors'
require_relative 'constants'

puts "=== CLI Lab Booking System ==="

# Pre-created data this will make it easier to test
users = [
  User.new(id: 1, name: "Mahi", role: LabBooking::ROLE[:student]),
  User.new(id: 2, name: "Alex", role: LabBooking::ROLE[:assistant]),
  User.new(id: 3, name: "Sarah", role: LabBooking::ROLE[:admin])
]

resources = [
  Resource.new(id: 1, name: "Microscope", category: "lab"),
  Resource.new(id: 2, name: "Projector",  category: "media"),
  Resource.new(id: 3, name: "Laptop",     category: "electronics"),
  Resource.new(id: 4, name: "Router Kit", category: "network")
]

manager = BookingManager.new
all_resources = resources  # used by available_resources

puts "#{users.size} users and #{resources.size} resources loaded."
puts "Type numbers to navigate. Press Ctrl+C to quit anytime.\n\n"

loop do
  puts "\n" + "=" * 40
  puts "1. List available resources"
  puts "2. List active bookings"
  puts "3. Create a new booking"
  puts "4. Cancel a booking"
  puts "5. Quit"
  puts "=" * 40
  print "\nChoose an option (1-5): "

  choice = gets.chomp.strip

  case choice
  when "1"  # List available resources
    available = manager.available_resources(all_resources)
    puts "\nAvailable Resources (#{available.size}):"
    if available.empty?
      puts "   None right now."
    else
      available.each do |r|
        puts "   #{r.id}. #{r.name} (#{r.category})"
      end
    end

  when "2"  # List active bookings
    active = manager.active_bookings
    puts "\nActive Bookings (#{active.size}):"
    if active.empty?
      puts "   No active bookings."
    else
      active.each do |b|
        puts "   #{b.user.name} → #{b.resource.name} (#{b.status})"
      end
    end

  when "3"  # Create booking
    puts "\nUsers:"
    users.each { |u| puts "   #{u.id}. #{u.name} (#{u.role})" }

    print "\nEnter User ID: "
    user_id = gets.chomp.to_i
    user = users.find { |u| u.id == user_id }
    unless user
      puts "User not found!"
      next
    end

    puts "\nAvailable Resources:"
    manager.available_resources(all_resources).each do |r|
      puts "   #{r.id}. #{r.name} (#{r.category})"
    end

    print "\nEnter Resource ID: "
    res_id = gets.chomp.to_i
    resource = all_resources.find { |r| r.id == res_id }

    begin
      booking = manager.create_booking(user, resource)
      puts "Booking created successfully!"
    rescue BookingError => e
      puts "#{e.message}"
    end

  when "4"
    active = manager.active_bookings
    if active.empty?
      puts "\nNo active bookings to cancel."
      next
    end

    puts "\nActive Bookings:"
    active.each_with_index do |b, i|
      puts "   #{i+1}. #{b.user.name} → #{b.resource.name}"
    end

    print "\nEnter number to cancel: "
    num = gets.chomp.to_i - 1
    booking_to_cancel = active[num]

    if booking_to_cancel
      begin
        booking_to_cancel.cancel
        puts "Booking cancelled. Resource is now available again!"
      rescue BookingError => e
        puts "#{e.message}"
      end
    else
      puts "Invalid number."
    end

  when "5"
    puts "\nGoodbye! Thanks for using the Lab Booking System."
    break

  else
    puts "Invalid option. Please enter 1-5."
  end
end