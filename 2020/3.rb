require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten.map{|x| x.split('')}

p d
i = 0
c = 0
d.each do |l|
  c += 1 if l[i % l.length] == '#'
  i += 3
end

i = 0
c2 = 0
d.each do |l|
  c2 += 1 if l[i % l.length] == '#'
  i += 1
end



i = 0
c3 = 0
d.each do |l|
  c3 += 1 if l[i % l.length] == '#'
  i += 5
end

i = 0
c4 = 0
d.each do |l|
  c4 += 1 if l[i % l.length] == '#'
  i += 7
end

i = 0
c5 = 0
d.each_with_index do |l, j|
  if j.even?
    c5 += 1 if l[i % l.length] == '#'
    i += 1
  end
end

p c * c2 * c3 * c4 * c5
