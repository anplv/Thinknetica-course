puts 'Введите день (число):'
day = gets.to_i

puts 'Введите месяц (номер):'
month = gets.to_i

puts 'Введите год:'
year = gets.to_i

feb_amount = 28
text = 'не високосный'

if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  feb_amount = 29
  text = 'високосный'
end

months = [31, feb_amount, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

result = day

(1...month).each do |num|
  result += months[num]
end

puts "Порядковый номер даты равен #{result}. Год #{text}!"
