d = open('2017/15.txt').read.split("\n")
a = d.first.split(' ').last.to_i
b = d.last.split(' ').last.to_i

fac = {
  a: 16807,
  b: 48271
}

div = 2147483647

res = 0
40000000.times do
  a = (a * fac[:a]) % div
  b = (b * fac[:b]) % div

  ab = '0000000000000000' + a.to_s(2)
  bb = '0000000000000000' + b.to_s(2)

  ab16 = ab[-16..-1]
  bb16 = bb[-16..-1]

  res += 1 if ab16 == bb16
end

p "Part1: #{res}"

a = d.first.split(' ').last.to_i
b = d.last.split(' ').last.to_i
ta = []
tb = []
tag = false
tbg = false
while true
  unless tag
    a = (a * fac[:a]) % div
    ta << a if a % 4 == 0
  end

  unless tbg
    b = (b * fac[:b]) % div
    tb << b if b % 8 == 0
  end

  tag = true if ta.length == 5000000
  tbg = true if tb.length == 5000000

  break if tag && tbg
end

res = 0

5000000.times do |i|
  ab = '0000000000000000' + ta[i].to_s(2)
  bb = '0000000000000000' + tb[i].to_s(2)

  ab16 = ab[-16..-1]
  bb16 = bb[-16..-1]
  res += 1 if ab16 == bb16
end

p "Part2: #{res}"
