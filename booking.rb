require_relative 'errors'
class Booking
  attr_reader :user, :resource, :status, :created_at
  def initialize(user:, resource:)
    unless [LabBooking::ROLE[:student], LabBooking::ROLE[:assistant]].include?(user.role)
      raise BookingError, "Only Student and Assistant can create booking."
    end

    unless resource.available?
      raise BookingError, "Cannot book #{resource.name}, it's already booked"
    end
    @user = user
    @resource = resource
    @status=LabBooking::STATUS[:active]
    @created_at = Time.now
    resource.assign_booking(self)
  end
  def cancel
    if @status == LabBooking::STATUS[:canceled]
      raise BookingError, "This book already cancelled."
    end
    @status = LabBooking::STATUS[:canceled]
    @resource.clear_booking
  end

end