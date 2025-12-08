d = open('8.txt').read.split("\n")

jbs = []
d.each_with_index do |l, i|
  jbs << [l.split(',')[0].to_i, l.split(',')[1].to_i, l.split(',')[2].to_i]
end

def distance(a,b)
  (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2 + (a[2] - b[2]) ** 2
end

dis = {}
jbs.each do |jb|
  jbs.each do |jbb|
    next if jb == jbb || dis[[jb, jbb].sort]

    dis[[jb, jbb].sort] = distance(jb, jbb)
  end
end

mins = dis.map { |k, v| [k, v]}.sort_by { |a| a.last}

i = 0
par = {}

until i == 1000
  min = mins.shift

  a = min.first.first
  b = min.first.last

  par[a] ||= a
  par[b] ||= b
  i += 1

  next if par[a] == par[b]

  par.select{|k,v| par[v] == par[b]}.each {|k,v| par[k] = par[a]}

end

c = {}

par.keys.each do |pt|
  c[pt] ||= 0
  par.values.each do |pa|
    c[pt] += 1 if pa == pt
  end
end

p "Part1: #{c.sort_by{|k,v| -v}.first(3).map(&:last).reduce(:*)}"

loop do
  min = mins.shift
  a = min.first.first
  b = min.first.last

  par[a] ||= a
  par[b] ||= b

  next if par[a] == par[b]

  par.select{|k,v| par[v] == par[b]}.each {|k,v| par[k] = par[a]}

  if par.values.uniq.length == 1 && par.keys.length == jbs.length
    p "Part2: #{a.first * b.first}"
    break
  end
end
