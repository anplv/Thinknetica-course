class Wagon
  include Manufacturer

  attr_reader :type, :volume, :occupied_volume

  def initialize(type, volume)
    @type = type
    @volume = volume.to_f
    @occupied_volume = 0
  end

  def empty_space
    @volume - @occupied_volume
  end
end
