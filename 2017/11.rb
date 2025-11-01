d = open('11.txt').read.split("\n").first.split(',')

s = 0
e = 0
res = 0
max = 0
d.each do |l|
  case l
  when 's'
    s += 1
  when 'n'
    s -= 1
  when 'se'
    s += 0.5
    e += 0.5
  when 'sw'
    s += 0.5
    e -= 0.5
  when 'ne'
    s -= 0.5
    e += 0.5
  when 'nw'
    s -= 0.5
    e -= 0.5
  end
  res = s.abs + e.abs
  max = s.abs + e.abs if s.abs + e.abs > max
end

p "Part1: #{res.to_i}"
p "Part2: #{max.to_i}"
