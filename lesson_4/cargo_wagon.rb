require_relative 'wagon'
class CargoWagon
  attr_reader :type

  def initialize(type)
    super(type)
    @type = 'грузовой'
  end
end
