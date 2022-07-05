require_relative 'controller'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

controller = Controller.new

loop do
  controller.action_menu
  user_choice = gets.chomp.downcase
  controller.run_action(user_choice)
end
