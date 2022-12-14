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

wide = 4 * (xmax - xmin)

grid = Array.new(ymax - ymin + 3) { Array.new(xmax - xmin + 1 + 2*wide) {'.'}}

drawlines.append([[xmin-wide, ymax+2], [xmax+wide, ymax+2]])

for dline in drawlines
  xstart, ystart, xstop, ystop = dline.flatten()
  if xstart == xstop
    for y in [ystart, ystop].sort()[0]..[ystart, ystop].sort()[1]
      grid[y-ymin][xstart+wide-xmin] = '#'
    end
  else
    for x in [xstart, xstop].sort()[0]..[xstart, xstop].sort()[1] 
      grid[ystart-ymin][x+wide-xmin] = '#'
    end
  end
end

oob = false
stopped = true
index = 0
until oob do
  if stopped
    coords = [500 + wide, 0]
    stopped = false
  end
  cx, cy = coords
  next_coords = [[cx, cy+1], [cx-1, cy+1], [cx+1, cy+1]]
  valid = [1, 1, 1]
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
      valid[index] = 0
    end
  end
  if valid.find_index(1).nil?
    stopped = true
    if grid[coords[1]-ymin][coords[0]-xmin] == 'O'
      oob = true
      break
    end
    grid[coords[1]-ymin][coords[0]-xmin] = 'O'
  else
    coords = next_coords[valid.find_index(1)]
  end
  index +=1
end

grid[-ymin][500+wide-xmin]

#for g in grid
# p g
#end

puts "Answer to part 2:\n"
p grid.flatten().count('O')