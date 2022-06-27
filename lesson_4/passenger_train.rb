require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(num)
    super
    @type = 'пассажирский'
  end
end
