require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

# p d

p1 = []
p2 = []
pp2 = false
d[1..].each do |c|
  if c.include?('Player')
    pp2 = true
  elsif pp2
    p2 << c.to_i
  else
    p1 << c.to_i
  end
end

def play_game(p1, p2)
  rounds = []
  while p1.any? && p2.any?
    w = 0
    c1 = p1.first
    c2 = p2.first
    return p1 if rounds.include?(p1 + p2)

    rounds << p1 + p2
    if p1.length - 1 >= c1 && p2.length - 1 >= c2
      res = play_game(p1[1..c1].clone, p2[1..c2].clone).first
      w = res == p1 ? 1 : 0
    elsif c1 > c2
      w = 1
    end
    if w == 1
      p1 << c1 << c2
    else
      p2 << c2 << c1
    end
    p1.delete_at(0)
    p2.delete_at(0)
  end
  p2.any? ? p2 : p1
end

win = play_game(p1, p2)

p p1
p p2

sum = 0

win.last.reverse.each_with_index do |c, j|
  sum += c * (j + 1)
end

p sum
p "Time elapsed: #{Time.now - t}s"

# 30895 too low
# 31319 too low
