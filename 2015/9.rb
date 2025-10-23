data = open("2015/9.txt").read

# Part 1
places = []
dis = {}
data.split("\n").map do |line|
  from = line.split(' to ').first
  to = line.split(' to ').last.split(' = ').first
  d = line.split(' to ').last.split(' = ').last.to_i
  places << from
  places << to
  dis[from] ||= {}
  dis[to] ||= {}
  dis[to][from] = d
  dis[from][to] = d
  
end
places.uniq!

p places
p dis

