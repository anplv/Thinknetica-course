require_relative 'train'

class CargoTrain < Train
  include InstanceCounter

  attr_reader :type

  def initialize(num)
    super
    @type = 'грузовой'
    validate_num!
  end
end
