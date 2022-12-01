caloriesList = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input01.txt"))
elvesCalories = caloriesList.split(/\n\n/)
calorieSum = []
for elf in elvesCalories
    calorieSum.push(elf.split(/\n/).map(&:to_i).sum)
end
puts "Answer to part 1:\n"
puts calorieSum.max

puts "Answer to part 2:\n"
puts calorieSum.sort.reverse[0, 3].sum