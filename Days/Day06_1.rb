require 'set'

datastream = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input06.txt"))

n = 3
m = 13
while Set.new(datastream[n-3..n].split('')).size() < 4
    n += 1
end

while Set.new(datastream[m-13..m].split('')).size() < 14
    m += 1
end

puts "Answer to part 1:\n"
puts n+1

puts "Answer to part 2:\n"
puts m+1
