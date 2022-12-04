require 'csv'

data_file = CSV.parse(open("data.csv").read)
d = data_file.flatten.map{|x| x.to_i}
sum = 0
d.each do |m|
  i = 0
  while m > 0
    sum += m unless i == 0
    m = m / 3 - 2
    i += 1
  end
end

p sum
