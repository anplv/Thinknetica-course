arr = ('a'..'z').to_a

hash = {}

arr.each do |letter|
  hash[letter.to_s] = arr.index(letter) + 1 if %w[a e i o u y].include?(letter)
end

puts hash.inspect
