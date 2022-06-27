require_relative 'wagon'
class PassengerWagon < Wagon
  attr_reader :type

  def initialize(type)
    super(type)
    @type = 'пассажирский'
  end
end
