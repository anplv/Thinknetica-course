require_relative 'train'
class CargoTrain < Train
  attr_reader :type

  def initialize(num)
    super(num)
    @type = 'грузовой'
  end

  def add_wagon(wagon)
    if wagon.type == type
      super
      puts 'Вагон прицеплен'
    else
      puts 'Невозможно прицепить! Вагон другого типа'
    end
  end
end
