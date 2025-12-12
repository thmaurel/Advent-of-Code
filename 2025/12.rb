# Best day <3

shs = [
  #  first part of input here
].map{|x| x.map{|y| y.split('')}}

d = open('12.txt').read.split("\n")
# d = open('12.txt').read.strip
# d = open('12.txt').read.split("\n").map(&:to_i)

res = 0

rs = []

d.each_with_index do |l, i|
  rs << {
    size: l.split(':').first.split('x').map(&:to_i),
    exp: l.split(': ').last.split.map(&:to_i)
  }
end

rs.each do |r|
  s = r[:size].reduce(:*)
  nb = r[:exp].each_with_index.map {|n, i| n * shs[i].flatten.count('#')}.sum
  res += 1 if nb <= s
end

p res
