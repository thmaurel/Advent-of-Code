n = open('2017/17.txt').read.to_i

s = [0, 1]
m = 2
i = 1

while m < 2018
  k = ((i + n) % s.length) + 1
  s.insert(k, m)
  i = k
  m += 1
end

p "Part1: #{s[s.index(2017) + 1]}"

i = 0
res = nil

(1..50000000).to_a.each do |k|
  i = ((i +  n) % k) + 1
  res = k if i == 1
end

p "Part2: #{res}"
