class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @trains_type = []
  end

  def add_train(train)
    @trains << train
    @trains_type << train.type
  end

  def list_trains
    @trains.each do |train|
      puts "#{train.type.capitalize} поезд номер #{train.num}"
    end
  end

  def list_count_trains
    @trains_type.uniq.each do |type|
      puts "Поездов типа '#{type.capitalize}' - #{@trains_type.count(type)} шт"
    end
  end

  def delete_train(train)
    @trains.delete(train)
  end
end
