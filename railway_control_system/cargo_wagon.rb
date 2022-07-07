require_relative 'wagon'
class CargoWagon < Wagon
  attr_reader :type, :volume

  def initialize(type, volume)
    super(type)
    validate!
    @volume = volume.to_f
    @empty_volume = @volume
    @occupied_volume = 0
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def take_volume(volume)
    @occupied_volume += volume.to_f
    @empty_volume -= volume.to_f
  end

  def show_occupied_volume
    @occupied_volume
  end

  def show_empty_volume
    @empty_volume
  end

  private

  def validate!
    raise 'Неверно указан тип вагона!' if type != 'грузовой'
  end
end
