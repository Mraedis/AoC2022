require 'set'

moves = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input09.txt")).split("\n")

head = [0, 0]
tail = [0, 0]
visited1 = Set.new
visited1 << tail
for m in moves
    dir, a = m.split(' ')
    amount = a.to_i
    while amount > 0
        old = head.dup()
        head[0] += 'LR'.include?(dir) ? 'LR'.index(dir) * 2 - 1 : 0
        head[1] += 'DU'.include?(dir) ? 'DU'.index(dir) * 2 - 1 : 0
        if (head[0] - tail[0]).abs() > 1 || (head[1] - tail[1]).abs() > 1
            tail = old
        end
        visited1 << tail.dup()
        amount -= 1
    end
end

snake = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
visited2 = Set.new
visited2 << snake[9].dup()
for m in moves
    dir, a = m.split(' ')
    amount = a.to_i
    while amount > 0
        snake[0][0] += 'LR'.include?(dir) ? 'LR'.index(dir) * 2 - 1 : 0
        snake[0][1] += 'DU'.include?(dir) ? 'DU'.index(dir) * 2 - 1 : 0
        for i in 1..9
            dx = snake[i-1][0] - snake[i][0]
            adx = dx.abs()
            dy = snake[i-1][1] - snake[i][1]
            ady = dy.abs()
            if adx > 1 || ady > 1
                snake[i][0] += (dx).abs() > 0 ? (dx) / (dx).abs() : 0
                snake[i][1] += (dy).abs() > 0 ? (dy) / (dy).abs() : 0
            end
        end
        visited2 << snake[9].dup()
        amount -= 1
    end
end

puts "Answer to part 1:\n"
puts visited1.size()

puts "Answer to part 2:\n"
puts visited2.size()
