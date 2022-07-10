# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  include InstanceCounter

  def initialize(num)
    super
    @type = 'грузовой'
    validate!
  end
end
