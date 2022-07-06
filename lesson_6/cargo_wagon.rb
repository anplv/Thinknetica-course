require_relative 'wagon'
class CargoWagon < Wagon
  attr_reader :type

  def initialize(type)
    super(type)
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Неверно указан тип вагона!' if type != 'грузовой'
  end
end
