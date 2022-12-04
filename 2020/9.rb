require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten.map{|x| x.to_i}

def is_sum(n, arr)
  res = []
  25.times do |i|
    25.times do |j|
      res << arr[i] + arr[j] unless arr[i] == arr[j]
    end
  end

  return res.include?(n)
end


d[25..-1].each_with_index do |n, ind|
  unless is_sum(n.to_i, d[ind..24 + ind])
    p "c'est cassé"
    p n
    p ind
    break
  end
end

broken = 217430975
br_ind = 559

d[0..559].each_with_index do |n, i|
  test = 0
  j = 0
  res = []
  while test < broken
    test += d[i + j]
    res << d[i + j]
    j += 1
  end
  if test == broken
    puts "GAGNE"
    p res.max + res.min
  end
end



