d = open('9.txt').read.split("\n").first

ign = false
gar = false

score = 0
cur = 1
garb = 0

d.split('').each do |c|
  if ign
    ign = false
  elsif gar && c == '!'
    ign = true
  elsif gar && c != '>'
    garb+=1
  elsif gar && c == '>'
    gar = false
  elsif c == '<'
    gar = true
  elsif c == '{'
    score += cur
    cur += 1
  elsif c == '}'
    cur -= 1
  end
end

puts "Part 1: #{score}"
puts "Part 2: #{garb}"
