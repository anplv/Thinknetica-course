puts 'Введите значение основания треугольника (а), см:'
a = gets.to_i

puts 'Введите значение высоты треугольника (h), см:'
h = gets.to_i

triangle_area = 0.5 * a * h

puts "Площадь треугольника равна #{triangle_area} см2"
