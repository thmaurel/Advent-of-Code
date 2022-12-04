require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten


e = d.first.split('').map(&:to_i)
l = e.length / 2

c = 0
d.first.split('').map(&:to_i).each_with_index do |n, i|
  c += n if n == d.first.split('').map(&:to_i)[(i + l) % (l * 2)]
end

p c
