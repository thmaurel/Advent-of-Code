d = open('3.txt').read.split("\n")

res = 0

d.each_with_index do |l, i|
  ns = l.split('').map(&:to_i)
  max = ns.max
  if ns.count(max) >= 2
    res += 10 * max + max
  else
    i = ns.index(max)
    if i < ns.length - 1
      max2 = ns[i..-1].select {|x| x != max }.max
      res += 10 * max + max2
    else
      max2 = ns.select{|x| x != max }.max
      res += 10 * max2 + max
    end
  end
end

p "Part1: #{res}"

res = 0

d.each do |l|
  tmp = []
  ns = l.split('').map(&:to_i)
  i = 0
  12.times do |k|
    max = ns[i..-12 + k].max
    i = ns[i..-12 + k].index(max) + 1 + i
    tmp << max
  end
  res += tmp.join('').to_i
end
p "Part2: #{res}"
