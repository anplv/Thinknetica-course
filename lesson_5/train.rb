class Train
  include Manufacturer

  attr_reader :num, :type, :wagons, :speed, :current_station

  @@trains = []

  def self.find(num)
    @@trains.find { |train_num| train_num == num }
  end

  def initialize(num)
    @num = num
    @type = type
    @wagons = []
    @speed = 0
    @current_station = 0
    @current_station_index = 0
    self.class.find(num)
    @@trains << num
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
    puts 'Вагон прицеплен'
  end

  def delete_wagon(wagon)
    @wagons.pop(wagon)
    puts 'Вагон отцеплен'
  end

  def take_route(route)
    @route << route
    @current_station = @route.stations[@current_station_index]
  end

  def go_forward
    @current_station_index += 1
  end

  def go_back
    @current_station_index -= 1
  end

  def next_station(route)
    route.stations[index_station(route) + 1]
  end

  def prev_station(route)
    route.stations[index_station(route) - 1]
  end

  private

  def index_station(route)
    route.station.index(@current_station)
  end
end
