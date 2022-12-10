require 'set'

moves = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input09.txt")).split("\n")

snakes = [Array.new(2) {[0, 0]}, Array.new(10) {[0, 0]}]
visited = Array.new(2) {Set.new([0, 0])}

for m in moves
    dir, a = m.split(' ')
    amount = a.to_i
    while amount > 0
        snakes.each_with_index do |snake,index|
            snake[0][0] += 'LR'.include?(dir) ? 'LR'.index(dir) * 2 - 1 : 0
            snake[0][1] += 'DU'.include?(dir) ? 'DU'.index(dir) * 2 - 1 : 0
            for i in (1...snake.size())
                dx = snake[i-1][0] - snake[i][0]
                adx = dx.abs()
                dy = snake[i-1][1] - snake[i][1]
                ady = dy.abs()
                if adx > 1 || ady > 1
                    snake[i][0] += adx > 0 ? dx / adx : 0
                    snake[i][1] += ady > 0 ? dy / ady : 0
                end
            end
            visited[index] << snake[-1].dup()
        end
        amount -= 1
    end
end

puts "Answer to part 1:\n"
puts visited[0].size()

puts "Answer to part 2:\n"
puts visited[1].size()
