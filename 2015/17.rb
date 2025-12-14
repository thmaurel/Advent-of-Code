d = open('17.txt').read.split("\n").map(&:to_i)

def dfs(n, st, d, res)
  st[n] = true
  res << st.select{|k,v| v}.map {|k,v| k} if st.select{|k,v| v}.map {|k,v| d[k]}.sum == 150
  return st[n] = false if st.select{|k,v| v}.map {|k,v| d[k]}.sum >= 150
  (n + 1..d.length - 1).to_a.select{|x| !st[x]}.each do |i|
    dfs(i, st, d, res)
  end
  st[n] = false
end

res = []

d.length.times do |k|
  st = {}
  dfs(k, st, d, res)
end

p "Part1: #{res.map {|x| x.sort}.uniq.length}"
p "Part2: #{res.count{|y| y.length == res.map{|x| x.length}.min}}"
