d = open('6.txt').read.split("\n")

# Part 2
res2 = 0

ops = d.last.split(' ')
cop = ops.length - 1

tmp = nil
(0..d.first.length).to_a.reverse.each do |i|
  op = ops[cop]
  if [d[0][i], d[1][i],  d[2][i], d[3][i]].uniq == [" "]
    cop -= 1
    res2 += tmp unless tmp.nil?
    tmp = nil
  else
    a = [d[0][i], d[1][i],  d[2][i], d[3][i]].select{|x| x != ' '}.join('').to_i
    case op
    when '+'
      tmp ||= 0
      tmp += a
    when '*'
      tmp ||= 1
      tmp *= a
    end
  end
end
res2 += tmp unless tmp.nil?

p "Part2: #{res2}"

# Part 1
d.map! do |l|
  l.split(' ')
end

res1 = 0

d.first.length.times do |i|
  case d.last[i]
  when '+'
    res1 += d[0][i].to_i + d[1][i].to_i + d[2][i].to_i + d[3][i].to_i
  when '*'
    res1 += d[0][i].to_i * d[1][i].to_i * d[2][i].to_i * d[3][i].to_i
  end
end

p "Part1: #{res1}"
