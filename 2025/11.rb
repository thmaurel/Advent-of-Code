d = open('11.txt').read.split("\n")

nbs = {}

d.each_with_index do |l, i|
  n = l.split(':').first
  nbz = l.split(': ').last.split(' ')
  nbs[n] = nbz
end

# Part 1
s = "you"
q = [s]

res = 0

while q.any?
  f = q.shift
  res += 1 if f == 'out'
  next unless nbs[f]
  nbs[f].each do |nb|
    q << nb
  end
end

p "Part1: #{res}"

# Part 2
# Storing in the hash val the number of way from every visited place to the out variable
def dfs(n, nbs, v, val, out)
  v[n] = true
  val[n] ||= 0

  if nbs[n]
    nbs[n].each do |nb|
      next if v[nb]

      dfs(nb, nbs, v, val, out)
    end
    nbs[n].each do |nb|
      val[n] = 1 if nb == out
      val[n] += val[nb] if val[nb] && v[nb]
    end
  end
end

s = 'svr'

val = {}
out = 'out'
dfs(s, nbs, {}, val, out)
# Getting the number of path from 'dac' to 'out'
a = val['dac']

out = 'dac'
val = {}
dfs(s, nbs, {}, val, out)
# Getting the number of path from 'fft' to 'dac'
b = val['fft']

out = 'fft'
val = {}
dfs(s, nbs, {}, val, out)
# Getting the number of path from 'svr' to 'fft'
c = val['svr']

p "Part2: #{a * b * c}"
# Bingo!
