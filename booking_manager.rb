require_relative 'constants'

class BookingManager
  attr_reader :bookings
  def initialize
    @bookings = []
  end
  def create_booking(user,resource)
    booking=Booking.new(user: user,resource: resource)
    @bookings << booking
    booking
  end
  def active_booking
    @bookings.select {|b| b.status == LabBooking::STATUS[:active]}
  end
  def available_resources(all_resources)
    all_resources.select(&:available?)
  end
  def all_bookings
    @bookings
  end
end