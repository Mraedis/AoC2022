rpsList = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input02.txt"))
rounds = rpsList.split(/\n/)
elves = []
wins = {"A" => {"X" => 3, "Y" => 6, "Z" => 0, }, "B" => {"X" => 0, "Y" => 3, "Z" => 6}, "C" => {"X" => 6, "Y" => 0, "Z" => 3}}
tool = {"X" => 1, "Y" => 2, "Z" => 3}
strat = {"X" => -1, "Y" => 0, "Z" => 1}
opts = ["A", "B", "C"]
tool2 = {"A" => 1, "B" => 2, "C" => 3}
points1 = 0
points2 = 0
for round in rounds
    p1, p2 = round.split(" ")
    points1 += wins[p1][p2] + tool[p2]
    
    used = opts[(opts.find_index(p1) + strat[p2]).modulo(3)]
    points2 += tool2[used] + 3 * (p2.ord - 88)
end
puts "Answer to part 1:\n"
puts points1

puts "Answer to part 2:\n"
puts points2
#puts calorieSum.sort.reverse[0, 3].sum