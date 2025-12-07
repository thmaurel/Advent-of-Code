d = open('7.txt').read.split("\n").map{|x| x.split('')}

res = 0
s = nil

d.each_with_index do |l, j|
  l.each_with_index do |c, i|
    s = [i, j] if c == 'S'
  end
end

v = {}
cur = [{n: s, par: -1}]
finals = []

until cur.empty?
  cur.sort_by! {|x| x[:n].last}
  f = cur.shift
  i = f[:n].first
  j = f[:n].last
  par = f[:par]
  finals << par if j == d.length - 1
  next if j == d.length - 1

  if d[j+1][i] == '.'
    cur << { n: [i, j+1], par: par }
  else
    cur << {n: [i-1, j+1], par: [i, j+1]} if i.positive? && v[[i, j+1]].nil?
    cur << {n: [i+1, j+1], par: [i, j+1]} if i < d.first.length - 1 && v[[i, j+1]].nil?
    res += 1 if v[[i, j+1]].nil?
    v[[i, j+1]] ||= 0
    v[[i, j+1]] += (par == -1 ? 1 : v[par])
  end
end

p "Part1: #{res}"
p "Part2: #{finals.map{|x| v[x]}.sum}"
