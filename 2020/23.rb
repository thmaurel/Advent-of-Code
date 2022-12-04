time = Time.now
v = %w(9 5 2 4 3 8 7 1 6).map(&:to_i)

h = {}
h[1] = { next: [6, 10], previous: 7 }
h[2] = { next: [4, 3], previous: 5 }
h[3] = { next: [8, 7], previous: 4 }
h[4] = { next: [3, 8], previous: 2 }
h[5] = { next: [2, 4], previous: 9 }
h[6] = { next: [10, 11], previous: 1 }
h[7] = { next: [1, 6], previous: 8 }
h[8] = { next: [7, 1], previous: 3 }
h[9] = { next: [5, 2], previous: 1000000 }

(10..1000000).to_a.each do |tt|
  if tt == 10
    h[tt] = { next: [tt + 1, tt + 2], previous: 6 }
  elsif tt == 1000000 - 1
    h[tt] = { next: [1000000, 9], previous: tt - 1 }
  elsif tt == 1000000
    h[tt] = { next: [9, 5], previous: tt - 1 }
  else
    h[tt] = { next: [tt + 1, tt + 2], previous: tt - 1 }
  end
end

c = 9

10000000.times do |u|
  p "u: #{u}" if u%1000000 == 0
  p "Time elapsed: #{Time.now - time}" if u%1000000 == 0
  # p c
  # p h[9]
  # p h.find { |_, val| val.first == c }


  nv = h[h[c][:next].last][:next].last

  ar  = [h[c][:next], h[h[c][:next].last][:next].first].flatten

  d = c - 1

  while d <= 0 || ar.include?(d)
    d -= 1
    d = 1000000 if d <=0
  end

  # c
  # c - 1
  # d
  # d - 1
  # ar[1]
  # ar[2]


  # b_c c ar_O ar_1 ar_2 nv


  # b_d d a_d

  h[ar[2]] = { next: h[d][:next], previous: ar[1] }
  h[ar[1]] = { next: [ar[2], h[d][:next].first], previous: ar[0] }
  h[ar[0]] = { next: [ar[1], ar[2]], previous: d }

  b_d = ar.include?(h[d][:previous]) ? c : h[d][:previous]
  a_d = h[d][:next].first
  h[d] = { next: ar[0..1], previous: b_d }
  h[a_d][:previous] = ar[2]

  h[b_d] = { next: [d, ar[0]], previous: ar.include?(h[b_d][:previous]) ? c : h[b_d][:previous] }

  b_c = h[c][:previous]

  h[c] = { next: [nv, h[nv][:next].first], previous: b_c == d ? ar[2] : b_c } # si on fout les trucs direct apres on est baisé
  h[b_c] = { next: [c, h[c][:next].first], previous: h[b_c][:previous] } unless b_c == d

  h[nv][:previous] = c
  c = nv
end

p h[1][:next].first * h[1][:next].last
p "Time elapsed: #{Time.now - time}s"

p h[1]
p h[h[1][:next].first]
# (10..1000000).to_a.each do |tt|
#   v << tt
# end

# # v = %w(3 8 9 1 2 5 4 6 7).map(&:to_i)

# tmp = []

# i = 0
# nv = false

# 10000000.times do |u|
#   if nv
#     i = v.index(nv)
#   end
#   cv = v[i]
#   nv = v[(i+4) % 9]
#   # p cv

#   tmp << v[(i + 1) % 9] << v[(i + 2) % 9] << v[(i + 3) % 9]

#   # p tmp

#   [(i + 1) % 9, (i + 2) % 9, (i + 3) % 9].sort.reverse.each do |j|
#     v.delete_at(j)
#   end

#   if v.include?(cv - 1)
#     dv = cv - 1
#   elsif v.include?(cv - 2)
#     dv = cv - 2
#   elsif v.include?(cv - 3)
#     dv = cv - 3
#   elsif v.include?(cv - 4)
#     dv = cv - 4
#   elsif v.include?(cv - 5)
#     dv = cv - 5
#   elsif v.include?(cv - 6)
#     dv = cv - 6
#   elsif v.include?(cv - 7)
#     dv = cv - 7
#   elsif v.include?(cv - 8)
#     dv = cv - 8
#   elsif v.include?(9)
#     dv = 9
#   elsif v.include?(8)
#     dv = 8
#   elsif v.include?(7)
#     dv = 7
#   elsif v.include?(6)
#     dv = 6
#   end

#   di = v.index(dv)
#   3.times do
#     v.insert(di + 1, tmp[-1])
#     tmp.delete_at(-1)
#   end

#   p "#{u}th times" if u%1000 == 0
# end

# res = v.index(1)
# p "It took #{Time.now - time}s"
# p v[res + 1] * v[res + 2]
# # 69724853
# # too low
