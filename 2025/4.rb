d = open('4.txt').read.split("\n")

def neighbours(d, n)
  i = n.first
  j = n.last

  nbs = []
  nbs << [i-1, j-1] if i.positive? && j.positive?
  nbs << [i-1, j] if i.positive?
  nbs << [i-1, j+1] if i.positive? && j < d.length - 1
  nbs << [i, j-1] if j.positive?
  nbs << [i, j+1] if j < d.length - 1
  nbs << [i+1, j-1] if i < d.first.length - 1 && j.positive?
  nbs << [i+1, j] if i < d.first.length - 1
  nbs << [i+1, j+1] if i < d.first.length - 1 && j < d.length - 1
  nbs
end

tmp = nil
p1 = 0
p2 = 0

while tmp.nil? || tmp.any?
  tmp = []
  d.each_with_index do |l, j|
    l.split('').each_with_index do |c, i|
      cnt = 0
      neighbours(d, [i,j]).each { |nb| cnt += 1 if d[nb.last][nb.first] == '@' }
      p1 += 1 if cnt < 4 && c == '@'
      tmp << [i, j] if cnt < 4 && c == '@'
    end
  end
  puts "Part1: #{p1}" if p2.zero?

  p2 += tmp.length
  tmp.each do |n|
    i = n.first
    j = n.last
    d[j][i] = '.'
  end
end

puts "Part2: #{p2}"
