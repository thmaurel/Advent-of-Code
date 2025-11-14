# Stupid bruteforce

d = open("2015/15.txt").read.split("\n")
h = {}

d.each do |l|
  name = l.split(' ').first
  capacity = l.split(' ')[2].gsub(',', '').to_i
  durability = l.split(' ')[4].gsub(',', '').to_i
  flavor = l.split(' ')[6].gsub(',', '').to_i
  texture = l.split(' ')[8].gsub(',', '').to_i
  calories = l.split(' ')[10].to_i
  h[name] = {capacity:, durability:, flavor:, texture:, calories:}
end

res1 = []
res2 = []
10000000.times do
  tot = 0
  cap = 0
  dur = 0
  fla = 0
  tex = 0
  cal = 0

  h.each do |k, v|
    q = k == "Candy:" ? 100 - tot : rand(0..100 - tot)
    tot += q
    cap += q * v[:capacity]
    dur += q * v[:durability]
    fla += q * v[:flavor]
    tex += q * v[:texture]
    cal += q * v[:calories]
  end
  cap = [cap, 0].max
  dur = [dur, 0].max
  fla = [fla, 0].max
  tex = [tex, 0].max

  res1 << cap * dur * fla * tex
  res2 << cap * dur * fla * tex if cal == 500
end

p "Part 1: #{res1.max}"
p "Part 2: #{res2.max}"