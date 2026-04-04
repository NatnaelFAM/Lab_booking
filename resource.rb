class Resource
  attr_accessor :booking_status
  def initialize(id, name, category)
    @id = id
    @name = name
    @category = category
    @booking_status=nil
    @available = true
  end
  def available?
    @available
  end

  def occupy(booking)
    @booking_status
  end
  def vacate
    @booking_status=nil
  end
end