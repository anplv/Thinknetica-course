# frozen_string_literal: true

require_relative 'wagon'
class PassengerWagon < Wagon
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

  def take_place
    @occupied_volume += 1 if empty_space.positive?
  end

  private

  def validate!
    raise 'Неверно указан тип вагона!' if type != 'пассажирский'
  end
end
