class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :num, :type, :wagons, :current_station, :routes

  TRAIN_NUM_FORMAT = /^[а-яёa-z0-9]{3}-?[а-яёa-z0-9]{2}$/i.freeze

  @@trains = []

  def self.find(num)
    @@trains.find { |train_num| train_num == num }
  end

  def initialize(num)
    @num = num
    validate_num!
    @type = type
    @wagons = []
    @speed = 0
    @current_station = 0
    @current_station_index = 0
    self.class.find(num)
    @@trains << num
    @routes = []
  end

  def current_speed
    @speed
  end

  def speed_up(num)
    @speed += num
  end

  def speed_down
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def delete_wagon
    validate_delete_wagon!
    @wagons.pop
  end

  def take_route(route)
    @routes.clear
    @routes << route
    @current_station = route.stations[@current_station_index]
  end

  def next_station
    validate_next_station!
    @current_station_index += 1
    @current_station = @routes.first.stations[@current_station_index]
  end

  def prev_station
    validate_prev_station!
    @current_station_index -= 1
    @current_station = @routes.first.stations[@current_station_index]
  end

  private

  def validate_num!
    raise 'Неверный формат номера поезда!' if num !~ TRAIN_NUM_FORMAT
  end

  def validate_delete_wagon!
    raise 'Невозможно отцепить вагон. Нет прицепленных вагонов!' if @wagons.empty?
  end

  def validate_next_station!
    raise 'Это конечная станция!' if @current_station == @routes.first.stations[-1]
  end

  def validate_prev_station!
    raise 'Это начальная станция!' if @current_station == @routes.first.stations[0]
  end
end
