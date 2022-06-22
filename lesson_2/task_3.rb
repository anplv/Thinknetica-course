num_1 = 1
num_2 = 1

arr = [0, 1, 1]

(2..100).each do |_item|
  num_1, num_2 = num_2, num_1 + num_2
  arr << num_2
end

puts arr.inspect
