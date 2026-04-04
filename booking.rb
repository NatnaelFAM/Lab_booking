require_relative 'errors'
class Booking
  attr_reader :user, :resource, :status, :created_at
  def initialize(user:, resource:, status:)
    @user = user
    @resource = resource
    @created_at = Time.now
    @status="Active"
  end
  def cancel
    @status = "Cancelled"
  end

end