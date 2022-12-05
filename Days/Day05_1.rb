moves = File.join(File.dirname(__FILE__),  "../Inputs/Input05.txt")
#moves = "move 1 from 2 to 1
#move 3 from 1 to 3
#move 2 from 2 to 1
#move 1 from 1 to 2"
#crates = ["ZN", "MCD", "P"]
crates1 = ["WBDNCFJ", "PZVQLST", "PZBGJT", "DTLJZBHC", "GVBJS", "PSQ", "BVDFLMPN", "PSMFBDLR", "VDTR"]
crates2 = ["WBDNCFJ", "PZVQLST", "PZBGJT", "DTLJZBHC", "GVBJS", "PSQ", "BVDFLMPN", "PSMFBDLR", "VDTR"]

for move in File.read(moves).split(/\n/)
#for move in moves.split(/\n/)
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
