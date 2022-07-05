require_relative 'wagon'
class CargoWagon < Wagon
  attr_reader :type

  def initialize(type)
    super(type)
    validate_type!
  end

  private

  def validate_type!
    raise 'Неверно указан тип вагона!' if type != 'грузовой'
  end
end
