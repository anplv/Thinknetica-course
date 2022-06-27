class Train
  attr_reader :num, :type, :wagons, :speed, :current_station

  def initialize(num)
    @num = num
    @type = type
    @wagons = []
    @speed = 0
    @current_station = 0
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
    @current_station = route.stations.first
  end

  def go_forward(route)
    @current_station = route.stations[index_station(route) + 1]
  end

  def go_back(route)
    @current_station = route.stations[index_station(route) - 1]
  end

  def next_station(route)
    route.stations[index_station(route) + 1]
  end

  def prev_station(route)
    route.stations[index_station(route) - 1]
  end

  protected

  # перенес в protected, т.к. эти методы вспомогательные
  def index_station(route)
    route.station.index(@current_station)
  end
end
