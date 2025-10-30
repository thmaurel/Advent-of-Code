d = open('10.txt').read.gsub("\n", '').split(',')

# p d

size = 256

li = (0..size - 1).to_a
cur = 0
skip = 0

d.map(&:to_i).each_with_index do |le, index|
  tmp = li + li
  ar = tmp[cur..cur + le - 1]
  ne = []
  if cur + le > size
    ne += ar.reverse[size - (cur + le)..-1]
    ne += li[cur + le - size..cur - 1]
    ne += ar.reverse[0..size - (cur + le) - 1]
  else
    ne += li[0..cur-1] if cur.positive?
    ne += ar.reverse
    ne += li[cur + le..-1] if cur+le < size
  end
  cur = (cur + le + skip) % size
  skip += 1
  li = ne
end

p "Part1: #{li[0] * li[1]}"

inp = []

d.each_with_index do |le, ind|
  le.split('').each do |i|
    inp << 48 + i.to_i
  end
  inp << 44 unless ind == d.length - 1
end

inp += [17, 31, 73, 47, 23]

size = 256

li = (0..size - 1).to_a
cur = 0
skip = 0
64.times do
  inp.each do |le|
    tmp = li + li
    ar = tmp[cur..cur + le - 1]
    ne = []
    if cur + le > size
      ne += ar.reverse[size - (cur + le)..-1]
      ne += li[cur + le - size..cur - 1]
      ne += ar.reverse[0..size - (cur + le) - 1]
    else
      ne += li[0..cur-1] if cur.positive?
      ne += ar.reverse
      ne += li[cur + le..-1] if cur+le < size
    end
    cur = (cur + le + skip) % size
    skip += 1
    li = ne
  end
end
res = []
li.each_slice(16) do |sl|
  hex = sl.reduce(&:^).to_s(16)
  res << (hex.length == 2 ? hex : '0' + hex)
end

p "Part2: #{res.join('')}"
