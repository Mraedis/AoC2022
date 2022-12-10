require 'set'

instructions = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input10.txt")).split("\n")

sslist = [1]
for instruction in instructions
    instr, value  = instruction.split(' ')
    case instr
    when 'addx'
        sslist.append(sslist[-1])
        sslist.append(sslist[-1] + value.to_i)
    when 'noop'
        sslist.append(sslist[-1])
    end
end

sssum = 0
display = []
temp = Array.new(40) {'.'}
sslist.each_with_index do |ss,index|
    if (index % 40 == 0 && index > 0)
        display.append(temp)
        temp = Array.new(40) {'.'}
    end
    if [20, 60, 100, 140, 180, 220].include? (index + 1)
        sssum += (index + 1) * ss
    end
    if ((index % 40)-1..(index % 40)+1).include? sslist[index]
        temp[index % 40] = '#'
    end
end

p sslist[0..20]
puts "Answer to part 1:\n"
puts sssum

puts "Answer to part 2:\n"
for d in display
    p d.join()
end