require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

class Tile
  attr_accessor :id, :grid, :neighbours

  def initialize(params = {})
    @id = params[:id]
    @grid = params[:grid]
    @neighbours = 0
  end

  def first_line
    @grid.first
  end

  def last_line
    @grid.last
  end

  def first_col
    @grid.map{|x| x[0]}.join('')
  end

  def last_col
    @grid.map{|x| x[-1]}.join('')
  end

  def is_neighbour?(tile)
    tile_borders = [tile.first_line, tile.last_line, tile.first_col, tile.last_col, tile.first_line.reverse, tile.last_line.reverse, tile.first_col.reverse, tile.last_col.reverse]
    borders = [first_line, last_line, first_col, last_col, first_line.reverse, last_line.reverse, first_col.reverse, last_col.reverse]
    intersection = tile_borders & borders
    intersection.any?
  end
end

tile = nil
tiles = []
grid = nil
d.each do |l|
  if l.include?("Tile")
    if tile
      tile.grid = grid
      tiles << tile
    end
    tile = Tile.new(id: l.split(' ').last.gsub(':','').to_i)
    grid = []
  else
    grid << l
  end
end

tile.grid = grid
tiles << tile


tiles.each do |tile|
  tiles.each do |ti|
    unless tile.id == ti.id
      tile.neighbours += 1 if tile.is_neighbour?(ti)
    end
  end
end

p tiles.map{|x| "ID:#{x.id} || neighbours: #{x.neighbours}"}
p "#######################"
p "#######################"
p "#######################"
p "#######################"
p tiles.select{|t| t.neighbours < 3}.map{|x| "ID:#{x.id} || neighbours: #{x.neighbours}"}
p tiles.select{|t| t.neighbours > 4}.length

sum = 1

tiles.select{|t| t.neighbours < 3}.each do |i|
  sum *= i.id
end

p sum

# tile = tiles.select{|x| x.id == 1619}.first

# p tile.first_line
# p tile.last_line
# p tile.first_col
# p tile.last_col

# p tile.first_line.reverse
# p tile.last_line.reverse
# p tile.first_col.reverse
# p tile.last_col.reverse

