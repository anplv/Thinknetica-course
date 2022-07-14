# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  include InstanceCounter
  include Validation

  validate :num, :presence
  validate :num, :format, TRAIN_NUM_FORMAT

  def initialize(num)
    super
    @type = 'грузовой'
    validate!
  end
end
