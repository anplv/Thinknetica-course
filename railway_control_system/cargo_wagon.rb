require_relative 'wagon'
class CargoWagon < Wagon
  def initialize(type, volume)
    super
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def take_volume(volume)
    @occupied_volume += volume if empty_space > volume
  end

  private

  def validate!
    raise 'Неверно указан тип вагона!' if type != 'грузовой'
  end
end
