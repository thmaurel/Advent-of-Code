require 'csv'

def compute(d)
  d.each_slice(4).each do |sl|
    if sl[0] == 1
      d[sl[3]] = d[sl[1]] + d[sl[2]]
    elsif sl[0] == 2
      d[sl[3]] = d[sl[1]] * d[sl[2]]
    elsif sl[0] == 99
      return d[0]
      break
    end
  end
end

(0..99).to_a.each do |i|
  (0..99).to_a.each do |j|
    data_file = CSV.parse(open("data.csv").read)
    d = data_file.flatten.map{|x| x.to_i}

    d[1] = i
    d[2] = j

    if compute(d) == 19690720
      p 100 * i + j
    end
  end
end

