d = open('2017/12.txt').read.split("\n")

nbs = {}

d.each do |l|
  k = l.split(' <-> ').first.to_i
  v = l.split(' <-> ').last.split(', ').map(&:to_i)
  nbs[k] = v
end

v = {}
part1 = nil
res = 0
nbs.keys.each do |k|
  next if v[k]

  s = k
  q = [s]
  v[s] = true

  while q.any?
    f = q.shift
    nbs[f].each do |nb|
      next if v[nb]

      v[nb] = true
      q << nb
    end
  end
  res += 1
  part1 = v.keys.length if k.zero?
end

p "Part1: #{part1}"
p "Part2: #{res}"
