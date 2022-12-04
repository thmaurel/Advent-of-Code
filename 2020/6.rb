require 'csv'
t = Time.now
data_file = CSV.parse(open("data.csv").read)

d = []
tmp = []

data_file.each do |ds|
  tmp << ds[0] unless ds == []
  d << tmp if ds == []
  tmp = [] if ds == []
end
d << tmp

r = 0
d.each do |ans|
  ans.join("").split("").uniq.each do |car|
    r +=  1 if ans.length == ans.join("").split("").count{|x| x == car}
  end
end

 p r
