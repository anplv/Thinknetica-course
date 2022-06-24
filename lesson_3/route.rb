class Route
  attr_reader :start, :stop, :all_stations, :station

  def initialize(start, stop)
    @station = [start, stop]
    @way_stations = []
  end

  def add_station(station)
    @way_stations << station
  end

  def delete_station(station)
    @way_stations.delete(station)
  end

  def list_station
    @all_stations = [@station.first, @way_stations, @station.last].flatten
    @all_stations.each do |station|
      puts station
    end
  end
end
