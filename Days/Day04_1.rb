require 'set'

assignments = File.join(File.dirname(__FILE__),  "../Inputs/Input04.txt")

overlaps1 = 0
overlaps2 = 0
for a in File.read(assignments).split(/\n/)
    a1, a2 = a.split(',')
    a11, a12 = a1.split('-')
    a21, a22 = a2.split('-')
    s1 = Set.new(a11..a12)
    s2 = Set.new(a21..a22)
    if s1 >= s2 or s2 >= s1 then
        overlaps1 += 1
    end
    if !(s1 & s2).empty?() then
        overlaps2 += 1
    end
end


puts "Answer to part 1:\n"
puts overlaps1

puts "Answer to part 2:\n"
puts overlaps2
