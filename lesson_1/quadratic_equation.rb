puts 'Введите коэффициент a'
a = gets.to_f

puts 'Введите коэффициент b'
b = gets.to_f

puts 'Введите коэффициент c'
c = gets.to_f

d = (b**2 - 4 * a * c)

if d.positive?
  x1 = (-b + Math.sqrt(d)) / 2 * a
  x2 = (-b - Math.sqrt(d)) / 2 * a
  puts "Дискриминант равен #{d}. Первый корень уравнения равен #{x1}. Второй корень уравнения равен #{x2}"
elsif d == 0
  x1 = -b / 2 * a
  puts "Дискриминант равен #{d}. Первый и второй корни уравнения равны #{x1}"
else
  puts "Дискриминант равен #{d}. Корней нет!"
end