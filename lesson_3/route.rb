class Route
<<<<<<< HEAD
  attr_reader :station
=======
  attr_reader :station
>>>>>>> 9e508fe (Refactor class Route)

  def initialize(start, stop)
    @station = [start, stop]
  end

  def add_station(station)
    @station.insert(-1, station)
  end

  def delete_station(station)
    @station.delete(station)
  end

  def list_station
    @station.each do |station|
      puts station
    end
  end
end
