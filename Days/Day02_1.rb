rpsList = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input02.txt"))
rounds = rpsList.split(/\n/)
points1 = 0
points2 = 0
for round in rounds
    p1, p2 = round.split(" ")
    # Convert A/B/C and X/Y/Z to their ord and calculate who wins what, add points for used weapon
    points1 += (p2.ord - 88 - (p1.ord - 66)).modulo(3) * 3 + (p2.ord - 87)
    points2 += 1 + ((p1.ord - 66) + (p2.ord - 88)).modulo(3) + 3 * (p2.ord - 88)
end
puts "Answer to part 1:\n"
puts points1

puts "Answer to part 2:\n"
puts points2