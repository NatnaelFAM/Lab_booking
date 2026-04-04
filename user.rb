class User
  attr_reader :id
  def initialize(id, name, role)
    @id = id
    @name = name
    @role = role
  end
end