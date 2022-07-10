# frozen_string_literal: true

require_relative '../modules/route_helper'
require_relative '../modules/station_helper'
require_relative '../modules/train_helper'
require_relative '../modules/wagon_helper'

class Controller
  include StationHelper
  include TrainHelper
  include RouteHelper
  include WagonHelper

  ACTION = { '1' => ['Создать станцию', :create_station],
             '2' => ['Создать поезд', :create_train],
             '3' => ['Создать маршрут', :create_route],
             '4' => ['Добавить станцию', :add_station],
             '5' => ['Удалить станцию', :delete_station],
             '6' => ['Назначить маршрут поезду', :take_route],
             '7' => ['Прицепить вагон к поезду', :add_wagon],
             '8' => ['Отцепить вагон от поезда', :delete_wagon],
             '9' => ['Переместить поезд вперед на одну станцию', :next_station],
             '10' => ['Переместить поезд назад на одну станцию', :prev_station],
             '11' => ['Просмотреть список станций', :list_station],
             '12' => ['Просмотреть список поездов на станции', :list_trains],
             '13' => ['Просмотреть список вагонов у поезда', :list_wagons],
             '14' => ['Занять место в вагоне', :take_place],
             '15' => ['Занять объём в вагоне', :take_volume],
             'cтоп' => ['Выйти из программы'] }.freeze

  TAKE_VOLUME_BLOCK = proc { |wagon|
    if user_wagon == wagon
      puts 'Введите необходимый объём, м3:'
      wagon.take_volume(gets.chomp.to_f)
    end
  }
  TAKE_PLACE_BLOCK = proc { |wagon|
    wagon.take_place if user_wagon == wagon
  }

  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def action_menu
    ACTION.each { |action, value| puts "|#{action}| -> '#{value.first}'" }
  end

  def run_action(user_action)
    return if stop_programm(user_action)
    return if not_valid_user_action(user_action)

    ACTION.each do |action, value|
      send(value[1]) if action == user_action
    end
  end

  private

  def stop_programm(user_action)
    abort if user_action.downcase == 'стоп'
  end

  def not_valid_user_action(user_action)
    raise 'Такой команды не существует!' unless ACTION.include?(user_action)
  end

  def create_station
    puts 'Введите название станции:'
    name = gets.strip.chomp
    uniq_station?(name)
    station = Station.new(name)
    @stations << station
    puts "Станция '#{station.name}' создана!"
  end

  def create_train
    puts 'Введите номер поезда:'
    num = gets.strip.downcase.chomp
    puts "Введите тип поезда ('пассажирский' или 'грузовой'):"
    type = gets.strip.downcase.chomp
    uniq_train?(num, type)
    train = get_train(type, num)
    @trains << train
    puts "#{type.capitalize} поезд номер #{num} создан!"
  end

  def create_route
    puts 'Введите название начальной станции маршрута:'
    first_station = Station.new(gets.strip.chomp)
    @stations << first_station
    puts 'Введите название конечной станции маршрута:'
    last_station = Station.new(gets.strip.chomp)
    uniq_route?(first_station, last_station)
    @stations.push(first_station, last_station)
    @routes << Route.new(first_station, last_station)
    puts 'Маршрут создан!'
    show_routes
  end

  def add_station
    route = selected_route
    puts 'Введите название промежуточной станции:'
    station = Station.new(gets.strip.chomp)
    @stations << station
    route.add_station(station)
    puts 'Промежуточная станция создана!'
  end

  def delete_station
    route = selected_route
    puts 'Введите название промежуточной станции:'
    station = find_station(gets.strip.chomp)
    route.delete_station(station)
    puts 'Промежуточная станция удалена!'
  end

  def take_route
    train = selected_train
    route = selected_route
    train.take_route(route)
    route.stations.first.add_train(train)
    puts "Для поезда '#{train.num}' назначен маршрут '#{route.stations.first.name}'!"
  end

  def add_wagon
    train = selected_train
    wagon = create_wagon(train)
    @wagons << wagon
    train.add_wagon(wagon)
    puts 'Вагон добавлен!'
  end

  def create_wagon(train)
    case train.type
    when 'грузовой'
      puts 'Введите общий объём вагона, м3:'
      wagon = CargoWagon.new('грузовой', gets.to_i)
    when 'пассажирский'
      puts 'Введите общее количество мест в вагоне, шт:'
      wagon = PassengerWagon.new('пассажирский', gets.to_i)
    end
    wagon
  end

  def delete_wagon
    trains_empty?
    train = selected_train
    wagons?(train)
    train.delete_wagon
    puts 'Вагон отцеплен!'
  end

  def next_station
    train = selected_train
    current_station?(train)
    train.current_station.add_train(train)
    train.next_station
    puts "Поезд '#{train.num}' отправлен на станцию '#{train.current_station.name}'!"
  end

  def prev_station
    train = selected_train
    current_station?(train)
    train.current_station.add_train(train)
    train.prev_station
    puts "Поезд '#{train.num}' отправлен на станцию '#{train.current_station.name}'!"
  end

  def list_station
    route = selected_route
    station_names_empty?(route)
    route.list_station
  end

  def list_trains
    station = selected_station
    block = ->(train) { puts "Поезд #{train.type} №#{train.num}. Количество вагонов - #{train.wagons.size} шт" }
    raise 'Поездов нет!' if station.trains.empty?

    station.check_trains(&block)
  end

  def list_wagons
    train = selected_train
    check_trains(train)
  end

  def take_place
    train = selected_train
    check_trains(train)
    puts 'Введите номер вагона для бронирования места:'
    user_wagon = select_wagon(gets.to_i)
    train.check_wagons(&TAKE_PLACE_BLOCK)
    puts "Место занято! Количество свободных мест - #{user_wagon.empty_space} шт."
  end

  def take_volume
    train = selected_train
    check_trains(train)
    puts 'Введите номер вагона для бронирования места в вагоне:'
    user_wagon = select_wagon(gets.to_i)
    train.check_wagons(&TAKE_VOLUME_BLOCK)
    puts "Место занято! Количество свободных мест - #{user_wagon.empty_space} м3."
  end

  # Вспомогательные методы

  def valid_user_input?(user_input, arr)
    raise 'Номер введен неверно!' unless arr.size >= user_input && user_input.positive?
  end
end
