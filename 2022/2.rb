require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten
# d = CSV.parse(open("data.csv").read).flatten.map(&:to_i)

# p d

score = 0

d.each do |g|
  score += 0 if g.split(" ").last == 'X'
  score += 3 if g.split(" ").last == 'Y'
  score += 6 if g.split(" ").last == 'Z'
  score += 1 if (g.split(" ").last == 'X' && g.split(" ").first == 'B') || (g.split(" ").last == 'Y' && g.split(" ").first == 'A') || (g.split(" ").last == 'Z' && g.split(" ").first == 'C')
  score += 2 if (g.split(" ").last == 'X' && g.split(" ").first == 'C') || (g.split(" ").last == 'Y' && g.split(" ").first == 'B') || (g.split(" ").last == 'Z' && g.split(" ").first == 'A')
  score += 3 if (g.split(" ").last == 'X' && g.split(" ").first == 'A') || (g.split(" ").last == 'Y' && g.split(" ").first == 'C') || (g.split(" ").last == 'Z' && g.split(" ").first == 'B')
  # score += 3 if (g.split(" ").last == 'X' && g.split(" ").first == 'A')
  # score += 3 if (g.split(" ").last == 'Y' && g.split(" ").first == 'B')
  # score += 3 if (g.split(" ").last == 'Z' && g.split(" ").first == 'C')
  # score += 6 if (g.split(" ").last == 'X' && g.split(" ").first == 'C')
  # score += 6 if (g.split(" ").last == 'Y' && g.split(" ").first == 'A')
  # score += 6 if (g.split(" ").last == 'Z' && g.split(" ").first == 'B')

end

p score
