require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

f = 0
fs = []
while true
  d.map(&:to_i).each do |i|
    f += i
    p f if fs.include?(f)
    return if fs.include?(f)
    fs << f
  end
end

p "toto"

