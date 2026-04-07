require "minitest/autorun"
require_relative "../user"
require_relative "../resource"
require_relative "../booking"
require_relative "../booking_manager"
require_relative "../errors"
require_relative "../constants"

class BookingTest < Minitest::Test
  def setup
    @user = User.new(id: 1, name: "Mahi", role: "student")
    @resource = Resource.new(id: 1, name: "Microscope", category: "lab")
  end

  def test_booking_an_available_resource_creates_an_active_booking
    booking = Booking.new(user: @user, resource: @resource)

    assert_equal "active", booking.status
    assert_equal false, @resource.available?
    assert_equal @user, booking.user
    assert_equal @resource, booking.resource
  end

  def test_booking_an_unavailable_resource_raises_an_error
    Booking.new(user: @user, resource: @resource)

    assert_raises(BookingError) do
      Booking.new(user: @user, resource: @resource)
    end
  end

  def test_cancelling_a_booking_changes_its_status
    booking = Booking.new(user: @user, resource: @resource)
    booking.cancel

    assert_equal "canceled", booking.status
  end

  def test_cancelling_a_booking_makes_the_resource_available_again
    booking = Booking.new(user: @user, resource: @resource)
    booking.cancel

    assert_equal true, @resource.available?
  end

  def test_only_student_or_assistant_can_book
    admin = User.new(id: 3, name: "Sarah", role: "admin")
    assert_raises(BookingError) do
      Booking.new(user: admin, resource: @resource)
    end
  end

  def test_booking_manager_stores_bookings
    manager = BookingManager.new
    manager.create_booking(@user, @resource)

    assert_equal 1, manager.all_bookings.size
    assert_equal "active", manager.active_booking.first.status
  end
end