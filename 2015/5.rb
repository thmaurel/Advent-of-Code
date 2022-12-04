t = open("5.txt").read

v = %w(a e i o u)

b = ["ab", "cd", "pq", "xy"]

c = 0

t.split("\n").each do |str|
  # part1 vs = 0
  # part1 str.split("").each{|l| vs += 1 if v.include?(l)}
  # part1 d = false
  # part1 str.split("").each_with_index{|l, j| d = true if l == str.split("")[j + 1]}
  # part1 b = (str.include?("ab") || str.include?("cd") || str.include?("pq") || str.include?("xy"))
  # part1 c += 1 if (vs > 2 && d && !b)
  d = false
  str.split("").each_with_index{|l, j| d = true if l == str.split("")[j + 2]}
  h = {}
  str.split("").each_with_index do |l, j|
    h["#{l}#{str[j+1]}"] += 1 if h["#{l}#{str[j+1]}"] && (str[j-1] != l || str[j+1] != l || str[j-2] == l)
    h["#{l}#{str[j+1]}"] = 1 unless h["#{l}#{str[j+1]}"]
  end
  m = h.values.select{|a| a > 1}
  c += 1 if (d && m.any?)
end

p c
