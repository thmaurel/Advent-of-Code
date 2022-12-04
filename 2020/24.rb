require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

d.map! do |i|
  j = []
  i.split('').each do |l|
    if ['s', 'n'].include?(j[-1])
      j[-1] += l
    else
      j << l
    end
  end
  j
end


ts = []

d.each do |l|
  x = 0
  y = 0
  l.each do |i|
    case i
    when 'e'
      x += 2
    when 'w'
      x -= 2
    when 'se'
      x += 1
      y -= 1
    when 'ne'
      x += 1
      y += 1
    when 'sw'
      x -= 1
      y -= 1
    when 'nw'
      x -= 1
      y += 1
    end
  end
  ts << [x, y]
end

 # ts.uniq.length

blacks = ts.uniq.select { |t| ts.count(t).odd? }





# p blacks
100.times do |u|
  alls = blacks.map{|x| [x, [x.first + 2, x.last], [x.first - 2, x.last], [x.first - 1, x.last + 1], [x.first - 1, x.last - 1], [x.first + 1, x.last + 1], [x.first + 1, x.last - 1]]}
  p "#{u}th times"
  new_blacks = []
  alls.flatten(1).each do |x, y|
    if blacks.include?([x, y])
      neighbours = [
        [x + 2, y],
        [x - 2, y],
        [x - 1, y + 1],
        [x - 1, y - 1],
        [x + 1, y + 1],
        [x + 1, y - 1]
      ]
      c = neighbours.count { |x| blacks.include?(x) }
      if c == 1 || c == 2
        new_blacks << [x, y]
      end
    else
      neighbours = [
        [x + 2, y],
        [x - 2, y],
        [x - 1, y + 1],
        [x - 1, y - 1],
        [x + 1, y + 1],
        [x + 1, y - 1]
      ]
      c = neighbours.count { |x| blacks.include?(x) }
      if c == 2
        new_blacks << [x, y]
      end
    end
  end
  blacks = new_blacks
end

p blacks.length












return

d.map! do |i|
  10.times do
    while i.include?('ne') && i.include?('sw')
      i.delete_at(i.index('ne'))
      i.delete_at(i.index('sw'))
    end
    while i.include?('se') && i.include?('nw')
      i.delete_at(i.index('se'))
      i.delete_at(i.index('nw'))
    end
    while i.include?('e') && i.include?('w')
      i.delete_at(i.index('e'))
      i.delete_at(i.index('w'))
    end
    while i.include?('ne') && i.include?('se')
      i.delete_at(i.index('ne'))
      i.delete_at(i.index('se'))
      i << 'e'
    end
    while i.include?('nw') && i.include?('sw')
      i.delete_at(i.index('nw'))
      i.delete_at(i.index('sw'))
      i << 'w'
    end
    while i.include?('e') && i.include?('w')
      i.delete_at(i.index('e'))
      i.delete_at(i.index('w'))
    end
    while i.include?('sw') && i.include?('e')
      i.delete_at(i.index('sw'))
      i.delete_at(i.index('e'))
      i << 'se'
    end
    while i.include?('nw') && i.include?('e')
      i.delete_at(i.index('nw'))
      i.delete_at(i.index('e'))
      i << 'ne'
    end
  end
  i
end

p d.sort.length
p d.sort.uniq.length


p d.sort.uniq == d.sort

p d.sort.uniq.select{|l| d.sort.count(l).odd?}.count

d[0..5].each do |l|
  p l
end
