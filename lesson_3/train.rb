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
    @current_station = route.start
  end

  # Мне не нравится, что идет повтор в 38, 43, 48 и 53 строках, но как это решить не придумал
  def go_forward(route)
    @index_station = route.all_stations.index(@current_station)
    @current_station = route.all_stations[@index_station + 1]
  end

  def go_back(route)
    @index_station = route.all_stations.index(@current_station)
    @current_station = route.all_stations[@index_station - 1]
  end

  def next_station(route)
    @index_station = route.all_stations.index(@current_station)
    route.all_stations[@index_station + 1]
  end

  def prev_station(route)
    @index_station = route.all_stations.index(@current_station)
    route.all_stations[@index_station - 1]
  end
end
