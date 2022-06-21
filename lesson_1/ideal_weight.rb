puts 'Введите ваше имя:'
name = gets.chomp.capitalize

puts 'Введите ваш рост, см:'
height = gets.to_i

ideal_weight = (height - 110) * 1.15

puts ideal_weight.positive? ? "#{name}, ваш иделальный вес - #{ideal_weight} кг!" : 'Ваш вес уже оптимальный'
