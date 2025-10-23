ns = open("2015/10.txt").read.split('')

#Part 1
res = nil
tmp = ns
40.times do 
  mem = 1
  res = ''
  tmp.each_with_index do |n, i|
    if tmp[i + 1] == n
      mem += 1
    else
      res += "#{mem}#{n}"
      mem = 1
    end
  end
  tmp = res.split('')
end

puts res.length

# Part 2 : 
# /!\ takes time
res = nil
tmp = ns
50.times do |k|
  p k
  mem = 1
  res = ''
  tmp.each_with_index do |n, i|
    if tmp[i + 1] == n
      mem += 1
    else
      res += "#{mem}#{n}"
      mem = 1
    end
  end
  tmp = res.split('')
end

puts res.length