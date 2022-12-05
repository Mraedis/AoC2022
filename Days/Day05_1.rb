cratestack, moves = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input05.txt")).split(/\n\n/)

crates = []
for i in (0..((cratestack.split(/\n/).reverse[0].length+1)/4))
    crates.append("")
end
for line in cratestack.split(/\n/).reverse[1..]
    for i in (0..((line.length+1)/4))
        if line[i*4+1] =~ /\A\p{Alnum}+\z/ then
            crates[i] += line[i*4+1]
        end
    end
end

crates1 = crates.dup
crates2 = crates.dup

for move in moves.split(/\n/)
    amnt, frm, dest = move.scan(/\d+/)
    amnt, frm, dest = amnt.to_i, frm.to_i - 1, dest.to_i - 1
    ld1 = (crates1[frm][-amnt..-1]).reverse
    crates1[dest] += ld1
    crates1[frm] = crates1[frm][0..-amnt-1]

    ld2 = crates2[frm][-amnt..-1]
    crates2[dest] += ld2
    crates2[frm] = crates2[frm][0..-amnt-1]
end

puts "Answer to part 1:\n"
puts crates1.map{|c| c[-1]}.join('')

puts "Answer to part 2:\n"
puts crates2.map{|c| c[-1]}.join('')
