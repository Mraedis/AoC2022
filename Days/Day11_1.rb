require 'set'

def meval(old, mexpr)
    result = 0
    if mexpr.include? "*"
        left, right = mexpr.split(" * ")
        result = (left.gsub("old", old.to_s)).to_i * (right.gsub("old", old.to_s)).to_i
    else
        left, right = mexpr.split(" + ")
        result = (left.gsub("old", old.to_s)).to_i + (right.gsub("old", old.to_s)).to_i
    end
    return result
end
monkeys = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input11.txt")).split("\n\n")

monkeylist = []
# starting items []
# operation new round
# test [Operation, True , False]
for monkey in monkeys
    itlist = monkey.split("\n")
    startlist = itlist[1].split(": ")[1].split(', ').map { |x| x.to_i }
    nextlist = []
    opnew = itlist[2].split("= ")[1]
    monktest = itlist[3].split("by ")[1].to_i
    mtrue = itlist[4].split(" ")[-1].to_i
    mfalse = itlist[5].split(" ")[-1].to_i
    inspects = 0
    monkeylist.append([startlist, opnew, monktest, mtrue, mfalse, inspects])
end

gclist = []
for monkey in monkeylist
    gclist << monkey[2]
end
gclist = gclist.reduce(:lcm)

#for round in 0..19 # part 1
for round in 0..9999
    monkeylist.each_with_index do |monkey, index|
        for item in monkey[0]
            # worry = (meval(item, monkey[1]) / 3) # part 1
            worry = (meval(item, monkey[1]) % gclist)
            monkeylist[worry % monkey[2] == 0 ? monkey[3] : monkey[4]][0].append(worry)
            monkeylist[index][5] += 1
        end
        monkeylist[index][0] = []
    end
end

inslist = []
for monkey in monkeylist
    inslist << monkey[5]
end
inslist = inslist.sort()

puts "Answer to part 1:\n"
puts inslist[-1] * inslist[-2]
puts "Answer to part 2:\n"

# 2713310158
# 9999200007