d = open('data.txt').read.split("\n")

tiles = []
tile = nil
d.each do |l|
  if l.include?('Tile')
    tile = {id: l.split.last.to_i, tile: []}
  elsif l == ""
    tiles << tile
  else
    tile[:tile] << l.split('')
  end
end
tiles << tile

def tile_side(tile)
  res = []
  res << tile.first
  res << tile.first.reverse
  res << tile.last
  res << tile.last.reverse
  res << tile.map(&:last)
  res << tile.map(&:last).reverse
  res << tile.map(&:first)
  res << tile.map(&:first).reverse
  res
end

def display_tile(tile)
  tile.each do |tc|
    puts tc.join
  end
end

def tiles_by_id(tiles, id)
  tiles.find { |t| t[:id] == id }
end

# Storing in map the number of neighbours of each tile
map = {}

tiles.each do |tile|
  c = 0
  tiles.each do |til|
    next if tile == til

    c += 1 if (tile_side(tile[:tile]) & tile_side(til[:tile])).any?
  end
  map[tile[:id]] = c
end

# The corners are necessarily the ones with 2 neighbours only
p "Part1: #{map.select{ |k,v| v == 2}.map{|k,v| k}.reduce(:*)}"

# Starting from 1 corner, we'll find a straight line to another corner (one side)
done = []

nbs = map.select { |k, v| v == 2 }
nb = nbs.first.first
done << nb

# We keep going to the next neighbours with only 3 sides matching other tiles, meaning it's on the edge
# When we get to one with only 2 sides matching, it's the corner we were looking for. First line is done
until nb.nil?
  tile = tiles.find{|tile| tile[:id] == nb}
  nbs = []
  tiles.select{|t| !done.include?(t[:id])}.each do |til|
    next if tile == til

    nbs << til[:id] if (tile_side(tile[:tile]) & tile_side(til[:tile])).any? && map[til[:id]] == 3
    done << til[:id] if (tile_side(tile[:tile]) & tile_side(til[:tile])).any? && map[til[:id]] == 2
  end

  nb = nbs.first
  done << nb unless nb.nil?
end

lines = [done.map{|x| x}]

# From this line, we can find the next ones by just getting the un-used neighbours of every single tile
until map.length == lines.flatten.length
  new_line = lines.last.map do |tile_id|
    tile =tiles.find{|tile| tile[:id] == tile_id}
    tiles.select{|t| !lines.flatten.include?(t[:id])}.find { |til| (tile_side(tile[:tile]) & tile_side(til[:tile])).any? }[:id]
  end

  lines << new_line
end

# Now we need to put every single tiles in the correct direction

# first we take the top left corner tile and compare it with its 2 neighbours to place it correctly
nw = lines.first.first
tile0 = tiles.find{|t| t[:id] == nw}[:tile]
tile1 = tiles.find{|t| t[:id] == lines.first[1]}[:tile]
tile2 = tiles.find{|t| t[:id] == lines[1].first}[:tile]

# Check which side match right neighbour to see how many rotation needed
sx = 3 if ([tile0.first] & tile_side(tile1)).any?
sx = 0 if ([tile0.map(&:last)] & tile_side(tile1)).any?
sx = 1 if ([tile0.last] & tile_side(tile1)).any?
sx = 2 if ([tile0.map(&:first)] & tile_side(tile1)).any?

# Check which side match bottom neighbour to see if we need to flip it
sy = 2 if ([tile0.first] & tile_side(tile2)).any?
sy = 3 if ([tile0.map(&:last)] & tile_side(tile2)).any?
sy = 0 if ([tile0.last] & tile_side(tile2)).any?
sy = 1 if ([tile0.map(&:first)] & tile_side(tile2)).any?

# this method reverses a tile horizontally
def hreverse(tile)
  {
    id: tile[:id],
    tile: tile[:tile].map{|x| x.reverse}
  }
end

# this method reverses a tile vertically
def vreverse(tile)
  {
    id: tile[:id],
    tile: tile[:tile].reverse
  }
end

# this method rotates a tile clockwisely
def rotateleft(tile)
  res = []
  tile[:tile].length.times do
    tmp = []
    tile[:tile].first.length.times { tmp << ''}
    res << tmp
  end
  tile[:tile].each_with_index do |t, j|
    t.each_with_index do |c, i|
      res[tile[:tile].length - 1 - i][j] = c
    end
  end
  {
    id: tile[:id],
    tile: res
  }
end

# We can initialize the correct array with tile properly placed and put the first tile in
lines_fixed = []
new_line = []
tile = tiles.find{|t| t[:id] == nw}
tile = hreverse(tile) if sy != sx
sx.times do
  tile = rotateleft(tile)
end
new_line << tile

# Then we can put everysingle tile in it based on its left neighbour or on its top if it's the first of the line
lines.each_with_index do |line, j|
  line.each_with_index do |till, i|
    next if i.zero? && j.zero?

    ctil = tiles_by_id(tiles, till)

    if i.positive?
      ls = new_line[i-1][:tile].map(&:last)
      if ctil[:tile].map(&:first) == ls
        new_line << ctil
      elsif ctil[:tile].map(&:first).reverse == ls
        new_line << vreverse(ctil)
      elsif ctil[:tile].map(&:last) == ls
        new_line << hreverse(ctil)
      elsif ctil[:tile].map(&:last).reverse == ls
        new_line << hreverse(vreverse(ctil))
      elsif ctil[:tile].first == ls
        new_line << vreverse(rotateleft(ctil))
      elsif ctil[:tile].first.reverse == ls
        new_line << rotateleft(ctil)
      elsif ctil[:tile].last == ls
        new_line << hreverse(vreverse(rotateleft(ctil)))
      elsif ctil[:tile].last.reverse == ls
        new_line << hreverse(rotateleft(ctil))
      end
    else
      new_line = []
      ts = lines_fixed[j-1][0][:tile].last
      if ctil[:tile].map(&:first) == ts
        new_line << vreverse(rotateleft(ctil))
      elsif ctil[:tile].map(&:first).reverse == ts
        new_line << hreverse(vreverse(rotateleft(ctil)))
      elsif ctil[:tile].map(&:last) == ts
        new_line << rotateleft(ctil)
      elsif ctil[:tile].map(&:last).reverse == ts
        new_line << hreverse(rotateleft(ctil))
      elsif ctil[:tile].first == ts
        new_line << ctil
      elsif ctil[:tile].first.reverse == ts
        new_line << hreverse(ctil)
      elsif ctil[:tile].last == ts
        new_line << vreverse(ctil)
      elsif ctil[:tile].last.reverse == ts
        new_line << vreverse(hreverse(ctil))
      end
    end
  end
  lines_fixed << new_line
end

# We now build the real map removing the borders
real_map = lines_fixed.map do |line|
  line.map do |tf|
    tf[:tile][1..-2].map {|x| x[1..-2]}
  end
end

# Then we build the final map by joining everything in an array
final_map = []
real_map.each do |tl|
  8.times do |k|
    final_map << tl.map { |t| t.map{|x| x.join('')}[k]}.join('')
  end
end

# This method rotates the map clockwisely
def rotateleft_map(map)
  new_map = []
  map.length.times do
    tmp = []
    map.first.length.times { tmp << '.' }
    new_map << tmp
  end
  map.each_with_index do |l, j|
    l.length.times do |i|
      new_map[l.length - 1 - i][j] = map[j][i]
    end
  end
  new_map
end

# Then we'll count the number of monsters in the map.
# We rotate it 4 times, then reverse it and rotate it 4 times again to make sure we get the map correctly oriented

c = 0
4.times do
  final_map.each_with_index do |l, i|
    next if i.zero? || i == final_map.length - 1
    77.times do |j|
      if l[j] == '#'
        c += 1 if [final_map[i + 1][j + 1], final_map[i + 1][j + 4], l[j + 5], l[j + 6], final_map[i + 1][j + 7], final_map[i + 1][j + 10], l[j + 11], l[j + 12], final_map[i + 1][j + 13], final_map[i + 1][j + 16], l[j + 17], l[j + 18], l[j + 19], final_map[i - 1][j + 18] ].uniq == ['#']
      end
    end
  end
  final_map = rotateleft_map(final_map)
end

final_map = final_map.map {|l| l.reverse}
4.times do
  final_map.each_with_index do |l, i|
    next if i.zero? || i == final_map.length - 1
    77.times do |j|
      if l[j] == '#'
        c += 1 if [final_map[i + 1][j + 1], final_map[i + 1][j + 4], l[j + 5], l[j + 6], final_map[i + 1][j + 7], final_map[i + 1][j + 10], l[j + 11], l[j + 12], final_map[i + 1][j + 13], final_map[i + 1][j + 16], l[j + 17], l[j + 18], l[j + 19], final_map[i - 1][j + 18] ].uniq == ['#']
      end
    end
  end
  final_map = rotateleft_map(final_map)
end

# The result is the number of # minus 15 times the monster count. (Monster has 15 '#')
res = final_map.join('').count('#') - c * 15

p "Part2: #{res}"
