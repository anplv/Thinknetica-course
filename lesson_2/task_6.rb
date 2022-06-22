db = {}
sum_cost = []

loop do
  puts 'Введите название товара:'
  product = gets.chomp
  break if product == 'стоп'

  puts 'Введите цену за 1 ед. товара, руб:'
  price = gets.to_f

  puts 'Введите количество купленного товара, шт:'
  amount = gets.to_f

  db[product.to_s] = { price: price, amount: amount }
end

puts db.inspect

db.each do |item, value|
  cost = value[:price] * value[:amount]
  sum_cost << cost
  puts " Стоимость товара '#{item}' составляет #{cost} руб"
end

puts "Итоговая стоимость: #{sum_cost.sum} руб"
