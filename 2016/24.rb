# Takes ~30s

d = open('24.txt').read.split("\n").map{|x| x.split('')}

pts = {}

d.each_with_index do |l, y|
  l.each_with_index do |c, x|
    pts[c.to_i] = [x, y] if c.match?(/\d+/)
  end
end

def nbs(f, d)
  x = f.first
  y = f.last
  nbs = []
  nbs << [ x - 1, y ] if d[y][x - 1] == '.' || d[y][x - 1].match?(/\d+/)
  nbs << [ x + 1, y ] if d[y][x + 1] == '.' || d[y][x + 1].match?(/\d+/)
  nbs << [ x, y - 1 ] if d[y - 1][x] == '.' || d[y - 1][x].match?(/\d+/)
  nbs << [ x, y + 1 ] if d[y + 1][x] == '.' || d[y + 1][x].match?(/\d+/)
  nbs
end

s = [ pts[0], { pts[0] => true }, { pts[0] => 0}, [] ]
q = [s]

cache = {}
part1 = true

while q.any?
  af = q.shift
  f = af[0]
  v = af[1].map{|x| x }.to_h
  dis = af[2].map{|x| x }.to_h
  done = af[3].map{|x| x}

  key = [done.sort, f]
  next if cache[key] && cache[key] <= dis[f]
  cache[key] = dis[f]

  pos = d[f.last][f.first]
  if pos.match?(/\d+/) && !done.include?(pos) && pos.to_i.positive?
    done << pos
    v = { f => true }
    dis = { f => dis[f] }
    if part1 && done.length == pts.length - 1
      p "Part1: #{dis[f]}"
      part1 = false
    end
  end
  if done.length == pts.length - 1 && pos == '0'
    p "Part2: #{dis[f]}"
    break
  end
  nbs(f, d).each do |nb|
    next if v[nb]

    q << [nb, v.merge(nb => true), dis.merge(nb => dis[f] + 1), done]
  end
end
