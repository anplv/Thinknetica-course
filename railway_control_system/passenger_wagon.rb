require_relative 'wagon'
class PassengerWagon < Wagon
  attr_reader :type

  def initialize(type, seats_number)
    super(type)
    validate!
    @seats_number = seats_number.to_i
    @empty_seats = @seats_number
    @occupied_seats = 0
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def take_place
    @empty_seats -= 1
    @occupied_seats += 1
  end

  def show_occupied_seats
    @occupied_seats
  end

  def show_empty_seats
    @empty_seats
  end

  private

  def validate!
    raise 'Неверно указан тип вагона!' if type != 'пассажирский'
  end
end
