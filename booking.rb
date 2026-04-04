require_relative 'errors'
class Booking
  attr_reader :user, :resource, :status, :created_at
  def initialize(user:, resource:)
    unless resource.available?
      raise BookingError, "Cannot book #{resource.name}, it's already booked"
    end
    @user = user
    @resource = resource
    @status="Active"
    @created_at = Time.now
    resource.assign_booking(self)
  end
  def cancel
    if @status == "Canceled"
      raise BookingError, "This book already cancelled."
    end
    @status = "Cancelled"
    @resource.clear_booking
  end

end