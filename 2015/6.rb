t = open("6.txt").read

grid = []
1000.times do
  a = []
  1000.times do
    a << 0
  end
  grid << a
end

t.split("\n").each do |ins|
  if ins.split.first == "toggle"
    xb = ins.split[1].split(",").first.to_i
    yb = ins.split[1].split(",").last.to_i
    xe = ins.split[3].split(",").first.to_i
    ye = ins.split[3].split(",").last.to_i
    (xb..xe).to_a.each do |x|
      (yb..ye).to_a.each do |y|
        grid[y][x] += 2
      end
    end
  elsif ins.split.first == "turn" && ins.split[1] == "on"
    xb = ins.split[2].split(",").first.to_i
    yb = ins.split[2].split(",").last.to_i
    xe = ins.split[4].split(",").first.to_i
    ye = ins.split[4].split(",").last.to_i
    (xb..xe).to_a.each do |x|
      (yb..ye).to_a.each do |y|
        grid[y][x] += 1
      end
    end
  elsif ins.split.first == "turn" && ins.split[1] == "off"
    xb = ins.split[2].split(",").first.to_i
    yb = ins.split[2].split(",").last.to_i
    xe = ins.split[4].split(",").first.to_i
    ye = ins.split[4].split(",").last.to_i
    (xb..xe).to_a.each do |x|
      (yb..ye).to_a.each do |y|
        grid[y][x] -= 1 if grid[y][x] > 0
      end
    end
  end
end

p grid.flatten.sum
