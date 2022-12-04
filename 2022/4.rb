require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

p d
cc = 0
d.each do |t|
  a = t.split(';').first.split('-').first.to_i
  b = t.split(';').first.split('-').last.to_i
  c = t.split(';').last.split('-').first.to_i
  d = t.split(';').last.split('-').last.to_i
  cc += 1 unless ((a..b).to_a & (c..d).to_a).empty?
end

p cc
