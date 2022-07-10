# frozen_string_literal: true

module TrainHelper
  CARGO_WAGON_LIST = lambda { |wagon, index|
    puts "Вагон номер #{index + 1}. Тип вагона - #{wagon.type}." \
         "Свободный объём вагона - #{wagon.empty_space} м3." \
         "Занятый объём вагона - #{wagon.occupied_volume} м3"
  }
  PASSENGER_WAGON_LIST = lambda { |wagon, index|
    puts "Вагон номер #{index + 1}. Тип вагона - #{wagon.type}" \
         "Количество свободных мест - #{wagon.empty_space} шт." \
         "Количество занятых мест - #{wagon.occupied_volume} шт"
  }
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def show_trains
      puts 'Список имеющихся поездов:'
      @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.num}" }
    end

    def get_train(type, num)
      case type.downcase
      when 'грузовой'
        train = CargoTrain.new(num)
      when 'пассажирский'
        train = PassengerTrain.new(num)
      end
      train
    end

    def uniq_train?(num, type)
      @trains.each do |train|
        raise 'Такой поезд уже существует!' if train.num == num
      end
      raise 'Неверно указан тип поезда!' unless %w[пассажирский грузовой].include?(type)
    end

    def trains_empty?
      raise 'Поезда отсутствуют!' if @trains.empty?

      show_trains
    end

    def current_station?(train)
      raise 'Маршрут не был назначен!' if train.current_station.nil?

      show_trains
    end

    def selected_train
      trains_empty?
      puts 'Для выбора поезда введите его номер:'
      train_number = gets.to_i
      valid_user_input?(train_number, @trains)
      @trains[train_number - 1]
    end

    def check_trains(train)
      case train.type
      when 'грузовой'
        puts 'Список имеющихся вагонов: '
        train.check_wagons(&CARGO_WAGON_LIST)
      when 'пассажирский'
        puts 'Список имеющихся вагонов: '
        train.check_wagons(&PASSENGER_WAGON_LIST)
      end
    end
  end
end
