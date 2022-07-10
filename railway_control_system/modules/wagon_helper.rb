# frozen_string_literal: true

module WagonHelper
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def select_wagon(wagon_num)
      @wagons[wagon_num - 1]
    end

    def wagons?(train)
      raise 'К выбранному поезду не прицеплено ни одного вагона!' if train.wagons.empty?
    end
  end
end
