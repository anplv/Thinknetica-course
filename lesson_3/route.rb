class Route
  attr_reader :start, :stop, :all_stations

  def initialize(start, stop)
    @start = start
    @stop = stop
    @way_stations = []
  end

  def add_station(station)
    @way_stations << station
  end

  def delete_station(station)
    @way_stations.delete(station)
  end

  def list_station
    @all_stations = [@start, @way_stations, @stop].flatten
    @all_stations.each do |station|
      puts station
    end
  end
end
