class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = {}
    @freight_trains = 0
    @passenger_trains = 0
  end

  def add_train(train)
    @trains[train.num.to_s] = train.type
  end

  def check_type(type)
    if type == 'грузовой'
      @freight_trains += 1
    else
      @passenger_trains += 1
    end
  end

  def list_trains
    @trains.each do |train, type|
      check_type(type)
      puts "#{type.capitalize} поезд номер #{train}"
    end
  end

  def list_count_trains
    puts "Сейчас на станции #{@freight_trains} грузовых поездов и #{@passenger_trains} пассажирских!"
  end

  def delete_train(train)
    @trains.delete(train.num.to_s)
  end
end
