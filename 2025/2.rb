d = open('2.txt').read.strip.split(',')

res1 = 0
res2 = 0

d.each do |l|
  a = l.split('-').first.to_i
  b = l.split('-').last.to_i

  (a..b).to_a.each do |n|
    ns = n.to_s
    k = ns.length
    next if k == 1

    res1 += n if ns[0..k / 2 - 1] == ns[k / 2..k - 1]

    (1..k / 2).to_a.each do |j|
      if k % j == 0 && ns == (ns[0..j - 1] * (k / j))
        res2 += n
        break
      end
    end
  end
end

p "Part1: #{res1}"
p "Part2: #{res2}"
