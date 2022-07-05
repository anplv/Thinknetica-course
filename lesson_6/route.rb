class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    @station_names = [first.name, last.name]
    validate_route!
    register_instance
  end

  def add_station(station)
    validate_add_station!(station)
    @stations.insert(-2, station)
    @station_names.insert(-2, station.name)
  end

  def delete_station(station)
    validate_delete_station!(station)
    @stations.delete(station)
    @station_names.delete(station.name)
  end

  def list_station
    puts @station_name.uniq!
  end

  private

  def validate_route!
    raise 'Необходимо добавить начальную и конечную остановку' if @stations.size < 2
  end

  def validate_delete_station!(way_station)
    raise 'В маршруте не может быть меньше 2 станций!' if @stations.size < 2
    raise 'Такой станции нет в маршруте!' unless @station_names.include?(way_station.name)
  end

  def validate_add_station!(way_station)
    raise 'Такая станция уже есть в маршруте!' if @station_names.include?(way_station.name)
  end
end
