class Station
  include InstanceCounter

  attr_reader :name, :trains

  STATION_NAME_FORMAT = /^[0-9]+$/

  @@stations = 0

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @trains_type = []
    @@stations += 1
    register_instance
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Необходимо ввести минимум 2 символа!' if name.empty? || name.length < 2
    raise 'Названии станции не может состоять только из цифр!' if name =~ STATION_NAME_FORMAT
  end
end
