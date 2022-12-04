require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten.map(&:to_i)


ns = {}

d.each_with_index do |n, i|
  ns[n] = i + 1
end

p ns
c = d.length + 1 # 8
t = 0
# c = 8 / t = 0

#  i = 1 / ns[0] = 8 / t = 7 / c = 9
#  i = 3 / ns[7] = 9 / t  = 6 / c = 10
#  t = 0 / ns[0] =
while c < 30000000
  if ns.key?(t)
    i = ns[t]
    ns[t] = c
    t = c - i
  else
    ns[t] = c
    t = 0
  end
  c += 1
end

p t
# Part 1
# 1000.times do |i|
#   n = d.last
#   if d.count{|x| x == n} > 1
#     age = d[0..-2].reverse.index(n) + 1
#     d << age
#   else
#     d << 0
#   end
# end

# p d
# p d[30000000 - 1]
p "Elapsed time: #{Time.now - t}s"
