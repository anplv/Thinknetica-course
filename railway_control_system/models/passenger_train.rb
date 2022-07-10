# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter

  def initialize(num)
    super
    @type = 'пассажирский'
    validate!
  end
end
