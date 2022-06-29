require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter

  attr_reader :type

  def initialize(num)
    super
    @type = 'пассажирский'
    register_instance
  end
end
