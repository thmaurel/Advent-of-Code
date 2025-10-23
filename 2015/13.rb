# Stupid bruteforce

d = open("2015/13.txt").read.split("\n")
h = {}

d.each do |l|
  name = l.split(' ').first
  verb = l.split(' ')[2]
  value = l.split(' ')[3]
  nb = l.split(' ').last[0..-2]
  h[name] ||= {}
  h[name][nb] = value.to_i * (verb == 'gain' ? 1 : -1)
end

names = h.keys

# Part 1
res = []

100000.times do 
  names.shuffle!
  score = 0
  names.each_with_index do |name, i|
    score += h[name][names[i - 1]]  
    score += h[name][names[(i + 1) % names.length]]  
  end
  res << score
end

p "Part 1: #{res.max}"

# Part 2
names << 'me'
res = []

100000.times do 
  names.shuffle!
  score = 0
  names.each_with_index do |name, i|
    score += h[name]&.dig(names[i - 1]) || 0
    score += h[name]&.dig(names[(i + 1) % names.length]) || 0
  end
  res << score
end

p "Part 2: #{res.max}"