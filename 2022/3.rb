require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten
# d = CSV.parse(open("data.csv").read).flatten.map(&:to_i)

# p d

ap = ('a'..'z').to_a + ('A'..'Z').to_a
# c = 0
# d.each do |l|
#   type = l[0..l.length/2].split('') & l[l.length/2..-1].split('')
#   c += ap.index(type.first) + 1
# end

# p c
c = 0
d.each_slice(3) do |i|
  type = i.first.split('') & i[1].split('') & i.last.split('')
  c += ap.index(type.first) + 1
end

p c
