d = open('5.txt').read.split("\n")

rs = []
ids = []

d.each_with_index do |l, i|
  if l.include?('-')
    rs << (l.split('-').first.to_i..l.split('-').last.to_i)
  else
    ids << l.to_i
  end
end

# Part 1
res = 0

ids.each do |id|
  done = false
  rs.each do |r|
    if r.include?(id)
      done = true
      break
    end
  end
  res += 1 if done
end

p "Part1: #{res}"

# Part 2
res = 0

10.times do
  rs.map! do |r|
    nr = r
    rs.each do |r2|
      next if r == r2

      if nr.include?(r2.first) && !nr.include?(r2.last)
        nr = (nr.first..r2.last)
      elsif nr.include?(r2.last) && !nr.include?(r2.first)
        nr = (r2.first..nr.last)
      elsif r2.first < nr.first && r2.last > nr.last
        nr = r2
      end
    end
    nr
  end

  rs.uniq!
end

rs.each do |r|
  res += r.last - r.first + 1
end

p "Part2: #{res}"
