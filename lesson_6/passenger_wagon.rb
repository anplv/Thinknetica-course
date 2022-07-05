require_relative 'wagon'
class PassengerWagon < Wagon
  attr_reader :type

  def initialize(type)
    super(type)
    validate_type!
  end

  private

  def validate_type!
    raise 'Неверно указан тип вагона!' if type != 'пассажирский'
  end
end
