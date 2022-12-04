require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten
# d = CSV.parse(open("data.csv").read).flatten.map(&:to_i)

p d

ss = []
s = 0
d.each do |n|
  if n == 'a'
    ss << s
    s = 0
  else
    s += n.to_i
  end
end

p ss.sort.last(3).sum

# file = File.open("data.txt").read.split("\n")

# p file


# p File.open('data.txt').read.lines
