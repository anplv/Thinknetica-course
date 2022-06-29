class Wagon
  include Manufacturer

  attr_accessor :type

  def initialize(type)
    @type = type
  end
end