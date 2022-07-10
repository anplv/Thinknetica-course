# frozen_string_literal: true

module RouteHelper
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def show_routes
      puts 'Список имеющихся маршрутов:'
      @routes.each_with_index do |route, index|
        puts "#{index + 1}. #{route.stations.first.name} -> #{route.stations.last.name}"
      end
    end

    def uniq_route?(first_station, last_station)
      @routes.each do |route|
        if route.stations.first.name == first_station.name && route.stations.last.name == last_station.name
          raise 'Такой маршрут уже есть!'
        end
      end
    end

    def routes_empty?
      raise 'Маршруты отсутствуют!' if @routes.empty?

      show_routes
    end

    def station_names_empty?(route)
      raise 'Станций нет!' if route.station_names.empty?

      show_routes
    end

    def selected_route
      routes_empty?
      puts 'Для выбора маршрута введите его номер:'
      route_number = gets.to_i
      valid_user_input?(route_number, @routes)
      @routes[route_number - 1]
    end
  end
end
