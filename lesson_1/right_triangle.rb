puts 'Введите значение стороны a, см:'
a = gets.to_f

puts 'Введите значение стороны b, см:'
b = gets.to_f

puts 'Введите значение стороны c, см:'
c = gets.to_f

if a > b && a > c
  hypotenuse = a
  cathetus_1 = b
  cathetus_2 = c
elsif b > c && b > a
  hypotenuse = b
  cathetus_1 = a
  cathetus_2 = c
elsif c > a && c > b
  hypotenuse = c
  cathetus_1 = a
  cathetus_2 = b
end

if a == b && b == c
  puts 'Треугольник равносторонний'
elsif a == b || a == c || b == c
  puts 'Треугольник равнобедренный'
elsif hypotenuse**2 == (cathetus_1**2 + cathetus_2**2)
  puts 'Треугольник прямоугольный'
end
