def compare(left, right)
    if left.is_a?(Integer) && right.is_a?(Integer)
      return left < right
    end

    if left.is_a?(Array) && right.is_a?(Array)
      zipped = left.zip(right)
      zipped.each do |l, r|
        # If the elements are different, return the result of the comparison.
        unless l == r
          return compare(l, r)
        end
      end
      return left.length < right.length
    end
  
    if left.is_a?(Integer) && right.is_a?(Array)
      return compare([left], right)
    elsif left.is_a?(Array) && right.is_a?(Integer)
      return compare(left, [right])
    end
  end


pairsraw = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input13.txt")).split("\n\n")

indexsum = 0
packets = [[[2]], [[6]]]
pairsraw.each_with_index do |pair,index|
    left, right = pair.split("\n").map {|x| eval(x)}
    if compare(left, right) then
        indexsum += index + 1
    end
    packets.append(left)
    packets.append(right)
end

truthmap = { true => 1, false => -1, nil => 0}
packets = packets.sort { |r,l| truthmap[compare(l,r)] }


puts "Answer to part 1:\n"
puts indexsum
puts "Answer to part 2:\n"
puts (packets.find_index([[2]]) + 1) * (packets.find_index([[6]]) + 1)