# Solved part 2 manually counting on the graph. Pretty much coded what i did manually

d = open('22.txt').read.split("\n")

ns = []
d[2..-1].each do |l|
  x = l.split.first.split('-')[1][1..-1].to_i
  y = l.split.first.split('-').last[1..-1].to_i
  size = l.split[1][0..-2].to_i
  used = l.split[2][0..-2].to_i
  avail = l.split[3][0..-2].to_i
  use = l.split[4][0..-2].to_i
  ns << { x:, y:, size:, used:, avail:, use: }
end

res1 = 0
ns.each do |n1|
  ns.each do |n2|
    next if n1 == n2

    next if n1[:used].zero?

    res1 += 1 if n1[:used] <= n2[:avail]
  end
end

p "Part1: #{res1}"

xmax = ns.map{|x| x[:x]}.max + 1
ymax = ns.map{|x| x[:y]}.max + 1

mat = []
s = nil
ymax.times do |y|
  tmp = []
  xmax.times do |x|
    n = ns.find{|n| n[:x] == x && n[:y] == y}[:used]
    c = n < 100 ? '.' : '#'
    c = '_' if n.zero?
    s = [x, y] if n.zero?
    tmp << c
  end
  mat << tmp
end

# Way to print matrix to solve it graphically:
# mat.each do |x|
#   p x.join('')
# end

def nbs(n, mat)
  x = n.first
  y = n.last
  nbs = []
  nbs << [x - 1, y] if x.positive? && mat[y][x - 1] == '.'
  nbs << [x + 1, y] if x < mat.first.length - 1 && mat[y][x + 1] == '.'
  nbs << [x, y - 1] if y.positive? && mat[y - 1][x] == '.'
  nbs << [x, y + 1] if y < mat.length - 1 && mat[y + 1][x] == '.'
  nbs
end

q = [s]
v = { s => true}
dis = { s => 0}
while q.any?
  f = q.shift
  break if f == [xmax - 1, 0]
  nbs(f, mat).each do |nb|
    next if v[nb]

    q << nb
    v[nb] = true
    dis[nb] = dis[f] + 1
  end
end

p "Part2: #{dis[[xmax - 1, 0]] + 5 * (xmax - 2)}"
