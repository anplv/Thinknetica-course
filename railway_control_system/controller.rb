class Controller
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
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
    puts '|13| -> Просмотреть список вагонов у поезда'
    puts '|14| -> Занять место в вагоне'
    puts '|15| -> Занять объём в вагоне'
    puts '|Стоп| -> Выйти из программы'
  end

  def run_action(action)
    case action
    when '1'
      create_station
    when '2'
      create_train
    when '3'
      create_route
    when '4'
      add_station
    when '5'
      delete_station
    when '6'
      take_route
    when '7'
      add_wagon
    when '8'
      delete_wagon
    when '9'
      next_station
    when '10'
      prev_station
    when '11'
      list_station
    when '12'
      list_trains
    when '13'
      list_wagons
    when '14'
      take_place
    when '15'
      take_volume
    when 'стоп'
      abort
    else
      puts 'Такой команды не существует!'
    end
  end

  private

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
    num = gets.strip.chomp
    puts "Введите тип поезда ('пассажирский' или 'грузовой'):"
    type = gets.strip.downcase.chomp
    validate_create_train?(type, num)
  end

  def create_route
    puts 'Введите название начальной станции маршрута:'
    first_station = Station.new(gets.strip.chomp)
    @stations << first_station
    puts 'Введите название конечной станции маршрута:'
    last_station = Station.new(gets.strip.chomp)
    @stations << last_station
    if uniq_route?(first_station, last_station)
      @routes << Route.new(first_station, last_station)
      puts 'Маршрут создан!'
      show_routes
    else
      puts 'Такой маршрут уже есть!'
    end
  end

  def add_station
    return unless check_routes

    route = select_route(gets.to_i)

    return unless check_user_input(route)

    puts 'Введите название промежуточной станции:'
    station = Station.new(gets.strip.chomp)
    @stations << station
    route.add_station(station)
    puts 'Промежуточная станция создана!'
  end

  def delete_station
    return unless check_routes

    route = select_route(gets.to_i)

    return unless check_user_input(route)

    puts 'Введите название промежуточной станции:'
    station = Station.new(gets.strip.chomp)
    @stations << station
    route.delete_station(station)
    puts 'Промежуточная станция удалена!'
  end

  def take_route
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    return unless check_routes

    route = select_route(gets.to_i)

    return unless check_user_input(route)

    train.take_route(route)
    route.stations.first.add_train(train)
    puts "Для поезда '#{train.num}' назначен маршрут '#{route.stations.first.name}'!"
  end

  def add_wagon
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    wagon = create_wagon(train)
    @wagons << wagon
    train.add_wagon(wagon)
    puts 'Вагон добавлен!'
  end

  def create_wagon(train)
    cargo = 'грузовой'
    passenger = 'пассажирский'
    if train.type == cargo
      puts 'Введите общий объём вагона, м3:'
      value = gets.to_i
      wagon = CargoWagon.new(cargo, value)
    elsif train.type == passenger
      puts 'Введите общее количество мест в вагоне, шт:'
      seats_number = gets.to_i
      wagon = PassengerWagon.new(passenger, seats_number)
    end
    wagon
  end

  def delete_wagon
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    train.delete_wagon
    puts 'Вагон отцеплен!'
  end

  def next_station
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    current_station = train.current_station

    if !current_station.nil?
      current_station.add_train(train)
      train.next_station
      puts "Поезд '#{train.num}' отправлен на станцию '#{train.current_station.name}'!"
    else
      puts 'Маршрут не был назначен!'
    end
  end

  def prev_station
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    current_station = train.current_station

    if !current_station.nil?
      current_station.delete_train(train)
      train.prev_station
      puts "Поезд '#{train.num}' отправлен на станцию '#{train.current_station.name}'!"
    else
      puts 'Маршрут не был назначен!'
    end
  end

  def list_station
    return unless check_routes

    route = select_route(gets.to_i)

    return unless check_user_input(route)

    if route.station_names.empty?
      puts 'Станций нет!'
    else
      route.list_station
    end
  end

  def list_trains
    return unless check_stations

    station = select_station(gets.to_i)

    return unless check_user_input(station)

    block = ->(train) { puts "Поезд #{train.type} №#{train.num}. Количество вагонов - #{train.wagons.size} шт" }
    if station.trains.empty?
      puts 'Поездов нет!'
    else
      station.check_trains(block)
    end
  end

  def list_wagons
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    check_wagons(train)
  end

  def take_place
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    check_wagons(train)
    puts 'Введите номер вагона для бронирования места:'
    user_wagon = select_wagon(gets.to_i)
    block = lambda { |wagon|
      wagon.take_place if user_wagon == wagon
    }
    train.check_wagons(&block)
    puts "Место занято! Количество свободных мест - #{user_wagon.empty_space} шт."
  end

  def take_volume
    return unless check_trains

    train = select_train(gets.to_i)

    return unless check_user_input(train)

    check_wagons(train)
    puts 'Введите номер вагона для бронирования места в вагоне:'
    user_wagon = select_wagon(gets.to_i)
    block = lambda { |wagon|
      if user_wagon == wagon
        puts 'Введите необходимый объём, м3:'
        wagon.take_volume(gets.chomp.to_f)
      end
    }
    train.check_wagons(&block)
    puts "Место занято! Количество свободных мест - #{user_wagon.empty_space} м3."
  end

  # Вспомогательные методы
  def show_stations
    puts 'Список имеющихся станций:'
    @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

  def show_routes
    puts 'Список имеющихся маршрутов:'
    @routes.each_with_index do |route, index|
      puts "#{index + 1}. #{route.stations.first.name} -> #{route.stations.last.name}"
    end
  end

  def show_trains
    puts 'Список имеющихся поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.num}" }
  end

  def select_station(station_num)
    @stations[station_num - 1]
  end

  def select_route(route_num)
    @routes[route_num - 1]
  end

  def select_train(train_num)
    @trains[train_num - 1]
  end

  def select_wagon(wagon_num)
    @wagons[wagon_num - 1]
  end

  def uniq_station?(name)
    @stations.each do |station|
      return false if station.name == name
    end
  end

  def check_stations
    if @stations.empty?
      puts 'Станции отсутствуют!'
      false
    else
      show_stations
      puts 'Для выбора станции введите её номер:'
      true
    end
  end

  def validate_create_train?(type, num)
    message = "#{type.capitalize} поезд номер #{num} создан!"
    if type.downcase == 'грузовой' && uniq_train?(num)
      train = CargoTrain.new(num)
      @trains << train
    elsif type.downcase == 'пассажирский' && uniq_train?(num)
      train = PassengerTrain.new(num)
      @trains << train
    elsif type.downcase != 'грузовой' && type.downcase != 'пассажирский'
      message = 'Неверно указан тип поезда!'
    elsif !uniq_train?(num)
      message = 'Такой поезд уже существует!'
    end
    puts message
  end

  def uniq_train?(num)
    @trains.each do |train|
      return false if train.num == num
    end
  end

  def check_trains
    if @trains.empty?
      puts 'Поезда отсутствуют!'
      false
    else
      show_trains
      puts 'Для выбора поезда введите его номер:'
      true
    end
  end

  def uniq_route?(first_station, last_station)
    @routes.each do |route|
      return false if route.stations.first.name == first_station.name && route.stations.last.name == last_station.name
    end
  end

  def check_routes
    if @routes.empty?
      puts 'Маршруты отсутствуют!'
      false
    else
      show_routes
      puts 'Для выбора маршрута введите его номер:'
      true
    end
  end

  def check_user_input(user_input)
    if user_input.nil?
      puts 'Номер выбран неверно!'
      false
    else
      true
    end
  end

  def check_wagons(train)
    count = 0
    cargo = lambda { |wagon|
      puts "Вагон номер #{count += 1}. Тип вагона - #{wagon.type}. Свободный объём вагона - #{wagon.empty_space} м3. Занятый объём вагона - #{wagon.occupied_volume} м3"
    }
    passenger = lambda { |wagon|
      puts "Вагон номер #{count += 1}. Тип вагона - #{wagon.type}. Количество свободных мест - #{wagon.empty_space} шт. Количество занятых мест - #{wagon.occupied_volume} шт"
    }

    case train.type
    when 'грузовой'
      puts 'Список имеющихся вагонов: '
      train.check_wagons(&cargo)
    when 'пассажирский'
      puts 'Список имеющихся вагонов: '
      train.check_wagons(&passenger)
    end
  end
end
