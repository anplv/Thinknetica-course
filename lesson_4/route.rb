class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station(station)
    @stations.insert(-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def list_station
    @stations.each do |station|
      puts station
    end
  end
end
