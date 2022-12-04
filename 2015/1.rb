t = open("1.txt").read
# p t
f = 0
t.split("").each_with_index do |i, pos|
  f += 1 if i == "("
  f -= 1 if i == ")"
  p pos + 1 if f == -1
  break if f == -1
end

p f
