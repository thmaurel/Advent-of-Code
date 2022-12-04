require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

p d

x = 0
y = 0
f = 'N'
vs = []
d.each do |i|
  case f
  when 'N'
    i[0] == 'R' ? f = 'E' : f = 'W'
  when 'S'
    i[0] == 'R' ? f = 'W' : f = 'E'
  when 'W'
    i[0] == 'R' ? f = 'N' : f = 'S'
  when 'E'
    i[0] == 'R' ? f = 'S' : f = 'N'
  end

  case f
  when 'N'
    i[1..-1].to_i.times do
      y += 1
      p [x,y] if vs.include?([x,y])
      return if vs.include?([x,y])
      vs << [x,y]
    end
  when 'S'
    i[1..-1].to_i.times do
      y -= 1
      p [x,y] if vs.include?([x,y])
      return if vs.include?([x,y])
      vs << [x,y]
    end
  when 'W'
    i[1..-1].to_i.times do
      x -= 1
      p [x,y] if vs.include?([x,y])
      return if vs.include?([x,y])
      vs << [x,y]
    end
  when 'E'
    i[1..-1].to_i.times do
      x += 1
      p [x,y] if vs.include?([x,y])
      return if vs.include?([x,y])
      vs << [x,y]
    end
  end

  vs << [x,y]
end

p [x, y]

# 275 too high
