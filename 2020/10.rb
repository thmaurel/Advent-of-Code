require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten.map{|x| x.to_i}
res = []
d.sort!
d.each_with_index{|x, i| i.zero? ? (res << x) : (res << (x - d[i - 1]))}
p res.count{|x| x== 1} * (res.count{|x| x== 3} + 1)

p "pouet"
p 2*7*7*7*4*7*2*4*4*7*7*7*7*7*4*2*7*7*4*7
