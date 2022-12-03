require 'set'

rucksacks = File.join(File.dirname(__FILE__),  "../Inputs/Input03.txt")

priorities1 = 0
for rs in File.read(rucksacks).split(/\n/)
    p1, p2 = rs[0, rs.length/2 ].split(''), rs[rs.length/2 , rs.length].split('')
    single = (Set.new(p1) & Set.new(p2)).to_a[0]
    priorities1 += single.ord > 96 ? single.ord - 96 : single.ord - 38
end

priorities2 = 0
File.foreach(rucksacks).each_slice(3) do |elves|
    e1, e2, e3 = elves[0].split(''), elves[1].split(''), elves[2].split('')
    single = (Set.new(e1) & Set.new(e2) & Set.new(e3)).to_a[0]
    priorities2 += single.ord > 96 ? single.ord - 96 : single.ord - 38
end

puts "Answer to part 1:\n"
puts priorities1

puts "Answer to part 2:\n"
puts priorities2