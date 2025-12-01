d = open('1.txt').read.split("\n")

res = 50
s = 0
s1 = 0
d.each_with_index do |l, i|
  if l[0] == 'L'
    l[1..-1].to_i.times do |j|
      res = (res - 1 ) % 100
      s += 1 if res.zero?
    end
  else
    l[1..-1].to_i.times do |j|
      res = (res + 1 ) % 100
      s += 1 if res.zero?
    end
  end
  s1 += 1 if res.zero?
end

p "Part1: #{s1}"
p "Part2: #{s}"
