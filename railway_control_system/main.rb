# frozen_string_literal: true

require_relative 'controllers/controller'
require_relative 'models/route'
require_relative 'models/station'
require_relative 'models/passenger_train'
require_relative 'models/cargo_train'
require_relative 'models/passenger_wagon'
require_relative 'models/cargo_wagon'
require_relative 'modules/instance_counter'
require_relative 'modules/manufacturer'
require_relative 'modules/route_helper'
require_relative 'modules/station_helper'
require_relative 'modules/train_helper'
require_relative 'modules/wagon_helper'

controller = Controller.new

loop do
  controller.action_menu
  user_choice = gets.chomp.downcase
  controller.run_action(user_choice)
end
