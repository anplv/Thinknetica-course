class Controller
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def action_menu
    puts 'Введите номер действия, которое хотите сделать:'
    puts '|1| -> Создать станцию'
    puts '|2| -> Создать поезд'
    puts '|3| -> Создать маршрут'
    puts '|4| -> Добавить станцию'
    puts '|5| -> Удалить станцию'
    puts '|6| -> Назначить маршрут поезду'
    puts '|7| -> Прицепить вагон к поезду'
    puts '|8| -> Отцепить вагон от поезда'
    puts '|9| -> Переместить поезд вперед на одну станцию'
    puts '|10| -> Переместить поезд назад на одну станцию'
    puts '|11| -> Просмотреть список станций'
    puts '|12| -> Просмотреть список поездов на станции'
    puts '|Стоп| -> Выйти из программы'
  end

  def run_action(action)
    case action
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      add_station
    when 5
      delete_station
    when 6
      take_route
    when 7
      add_wagon
    when 8
      delete_wagon
    when 9
      next_station
    when 10
      prev_station
    when 11
      list_station
    when 12
      list_train
    when 'стоп'
      abort
    else
      puts 'Такой команды не существует!'
    end
  end

  def create_station
    puts 'Введите название станции:'
    name = gets.strip.chomp
    if uniq_station?(name)
      station = Station.new(name)
      @stations << station
      puts 'Станция создана!'
    else
      puts 'Такая станция уже существует!'
    end
  end

  def create_train
    puts 'Введите номер поезда:'
    num = gets.to_i
    puts "Введите тип поезда ('пассажирский' или 'грузовой'):"
    type = gets.strip.downcase.chomp
    if type_cargo?(type) && uniq_train?(num)
      train = CargoTrain.new(num)
      @trains << train
    elsif type_passenger?(type) && uniq_train?(num)
      train = PassengerTrain.new(num)
      @trains << train
    elsif !type_cargo?(type) && !type_passenger?(type)
      puts 'Неверно указан тип поезда!'
    elsif !uniq_train?(num)
      puts 'Такой поезд уже существует!'
    end
  end

  def create_route
    puts 'Введите название начальной станции маршрута:'
    first_station = gets.strip.chomp
    puts 'Введите название конечной станции маршрута:'
    last_station = gets.strip.chomp
    route = Route.new(first_station, last_station)
    @routes << route
    puts 'Маршрут создан!'
    show_routes
  end

  def add_station
    input_route
    puts 'Введите название промежуточной станции:'
    station = gets.strip.chomp
    route.add_station(station)
    puts 'Промежуточная станция создана!'
  end

  def delete_station
    input_route
    if @stations.empty?
      puts 'Невозможно удалить станцию! Станции отсутствуют.'
    else
      puts 'Введите название промежуточной станции:'
      station = gets.strip.chomp
      route.delete_station(station)
      puts 'Промежуточная станция удалена!'
    end
  end

  def take_route
    input_route
    input_train
  end

  def add_wagon
    if @trains.empty?
      puts 'Для начала нужно создать поезд!'
    else
      puts 'Для добавления пассажирского вагона введите 1.'
      puts 'Для добавления грузового вагона введите 2.'
      user_input = gets.to_i
      if user_wagon_cargo?(user_input)
        wagon = CargoTrain.new(type)
        @wagons << wagon
      elsif user_wagon_passenger?(user_input)
        wagon = PassengerTrain.new(type)
        @wagons << wagon
      else
        puts 'Неверно указан тип вагона!'
      end
    end
  end

  def delete_wagon
    if @wagons.empty?
      puts 'Невозможно удалить вагон! Вагоны отсутствуют.'
    else
      puts 'Для отцепления пассажирского вагона введите 1.'
      puts 'Для отцепления грузового вагона введите 2.'
      user_input = gets.to_i
      if user_wagon_cargo?(user_input)
        @wagons.pop
      elsif user_wagon_passenger?(user_input)
        @wagons.pop
      else
        puts 'Неверно указан тип вагона!'
      end
    end
  end

  def next_station
    show_trains
    puts 'Введите название поезда:'
    train = gets.strip.chomp
    train.next_station
  end

  def prev_station
    show_trains
    puts 'Введите название поезда:'
    train = gets.strip.chomp
    train.prev_station
  end

  def list_station
    if @stations.empty?
      puts 'Станции отсутствуют!'
    else
      show_stations
    end
  end

  def list_train
    if @trains.empty?
      puts 'Вагоны отсутствуют!'
    else
      show_trains
    end
  end

  private

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def show_trains
    @trains.each { |train| puts train.num.to_i }
  end

  def show_routes
    @routes.each { |route| puts "#{route.stations.first} -> #{route.stations.last}" }
  end

  def uniq_station?(name)
    @stations.each do |station|
      return false if station.name == name
    end
  end

  def type_cargo?(type)
    type.downcase == 'грузовой'
  end

  def type_passenger?(type)
    type.downcase == 'пассажирский'
  end

  def uniq_train?(num)
    @trains.each do |train|
      return false if train.num == num
    end
  end

  def input_route
    if @routes.empty?
      puts 'Маршруты отсутствуют!'
    else
      puts 'Список имеющихся маршрутов:'
      show_routes(routes)
      puts 'Введите название маршрута:'
      route = gets.strip.chomp
    end
    route
  end

  def input_train
    if @trains.empty?
      puts 'Поезда! отсутствуют!'
    else
      puts 'Введите название поезда:'
      show_trains(@trains)
      train = gets.strip.chomp
    end
    train
  end

  def user_wagon_cargo?(wagon)
    return true if wagon == 2
  end

  def user_wagon_passenger?(wagon)
    return true if wagon == 1
  end
end
