t = open("2.txt").read

tot = 0
t.split("\n").each do |str|
  ns = str.split('x').map{|x| x.to_i}.sort
  # part 1: tot += 3 * ns[0] * ns[1] + 2 * ns[0] * ns[2] + 2 * ns[2] * ns[1]
  tot += 2 * ns[0] + 2 * ns[1] + ns[0] * ns[1] * ns[2]
end

p tot
