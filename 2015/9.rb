d = open('9.txt').read.split("\n")

h = {}
d.each do |l|
  from = l.split(' ').first
  to = l.split(' ')[2]
  dis = l.split(' ').last.to_i
  h[from] ||= []
  h[to] ||= []
  h[from] << [to, dis]
  h[to] << [from, dis]
end

pls = h.keys

def dfs(pl, h, st, pls, dis, res)
  st[pl] = true
  res << dis if pls.select{|x| st[x] != true}.empty?
  pls.select{|x| st[x] != true}.each do |nb|
    dfs(nb, h, st, pls, dis + h[pl].find{|x| x.first == nb}.last, res)
  end
  st[pl] = false
end

res = []
pls.each do |pl|
  st = {}
  dfs(pl, h,st, pls, 0, res)
end

p "Part1: #{res.min}"
p "Part2: #{res.max}"
