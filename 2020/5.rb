require 'csv'
t = Time.now
data_file = CSV.parse(open("data.csv").read).flatten


ids = []
data_file.each do |d|
  rs = d.split("")[0..6]
  cs = d.split("")[7..9]

  case cs.join("")
  when "RRR" then col = 7
  when "RRL" then col = 6
  when "RLR" then col = 5
  when "LRR" then col = 3
  when "RLL" then col = 4
  when "LRL" then col = 2
  when "LLR" then col = 1
  when "LLL" then col = 0
  end

  mn = 0
  mx = 127
  rs.each do |l|
    mn = (mn + mx) / 2 if l == "B"
    mx = (mn + mx) / 2 if l == "F"
  end

  row = mx


  id = row * 8 + col

  ids << id
end

p ids.sort

(46..915).to_a.each{|x| p x unless ids.include?(x)}
