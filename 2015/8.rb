data = open("2015/8.txt").read

# Part 1
p (data.split("\n").map do |line|
  line.length - line.gsub('\\\\', 'a').gsub('\"', 'a').gsub(/\\x[0-9aAbBcCdDeEfF]{2}/, 'a').length + 2
end.sum)

# Part 2
p (data.split("\n").map do |line|
  line.gsub('\\', 'aa').gsub('"', '\"').length + 2 - line.length
end.sum)