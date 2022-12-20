lines = File.read(File.join(File.dirname(__FILE__),  "../Inputs/Input14.txt")).split("\n")


drawlines = []
allcoords = [[500, 0]]
for line in lines
  dots = line.split(" -> ").map { |dot| dot.split(",").map { |d| d.to_i } }
  allcoords = allcoords.concat(dots)
  dots[..-2].each_with_index do |dot,index|
    drawlines.append([dots[index], dots[index+1]])
  end
end

xmax = allcoords.max_by {|coords| coords[0] }[0]
ymax = allcoords.max_by {|coords| coords[1] }[1]
xmin = allcoords.max_by {|coords| -1 * coords[0] }[0] # use as offset
ymin = allcoords.max_by {|coords| -1 * coords[1] }[1] # use as offset

grid = Array.new(ymax - ymin + 1) { Array.new(xmax - xmin + 1) {'.'}}


for dline in drawlines
  xstart, ystart, xstop, ystop = dline.flatten()
  if xstart == xstop
    for y in Range.new(*[ystart, ystop].minmax)
      grid[y-ymin][xstart-xmin] = '#'
    end
  else
    for x in Range.new(*[xstart, xstop].minmax)
      grid[ystart-ymin][x-xmin] = '#'
    end
  end
end

oob = false
stopped = true
index = 0
until oob do
  if stopped
    coords = [500, 0]
    stopped = false
  end
  cx, cy = coords
  next_coords = [[cx, cy+1], [cx-1, cy+1], [cx+1, cy+1]]
  valid = [0, 0, 0]
  next_coords.each_with_index do |nco,index|
    x,y = nco
    x += -xmin
    y += -ymin
    if y >= grid.length
      oob = true
      break
    elsif x >= grid[y].length
      oob = true
      break
    elsif 'O#'.include?(grid[y][x])
      valid[index] = 1
    end
  end
  if valid.find_index(0).nil?
    stopped = true
    grid[coords[1]-ymin][coords[0]-xmin] = 'O'
  else
    coords = next_coords[valid.find_index(0)]
  end
  index +=1
end

#for g in grid
# p g.join()
#end

puts "Answer to part 1:\n"
p grid.flatten().count('O')
