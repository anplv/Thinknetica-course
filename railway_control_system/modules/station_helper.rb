# frozen_string_literal: true

module StationHelper
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def show_stations
      puts 'Список имеющихся станций:'
      @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
    end

    def selected_station
      stations_empty?
      puts 'Для выбора станции введите её номер:'
      station_number = gets.to_i
      valid_user_input?(station_number, @stations)
      @stations[station_number - 1]
    end

    def find_station(station_name)
      @stations.each { |station| return station if station.name == station_name }
    end

    def uniq_station?(name)
      @stations.each do |station|
        raise 'Такая станция уже существует!' if station.name == name
      end
    end

    def stations_empty?
      raise 'Станции отсутствуют!' if @stations.empty?

      show_stations
    end
  end
end
