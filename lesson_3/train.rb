class Train
  attr_reader :num, :type, :wagon_num, :speed, :current_station

  def initialize(num, type, wagon_num)
    @num = num
    @type = type
    @wagon_num = wagon_num
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

  def add_wagon
    @wagon_num += 1
  end

  def delete_wagon
    @wagon_num -= 1
  end

  def take_route(route)
    @current_station = route.station.first
  end

  def index_station(route)
    route.all_stations.index(@current_station)
  end

  def go_forward(route)
    @current_station = route.all_stations[index_station(route) + 1]
  end

  def go_back(route)
    @current_station = route.all_stations[index_station(route) - 1]
  end

  def next_station(route)
    route.all_stations[index_station(route) + 1]
  end

  def prev_station(route)
    route.all_stations[index_station(route) - 1]
  end
end
