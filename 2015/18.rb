d = open("2015/18.txt").read.split("\n").map { |x| x.split('') }

hd = {}
d.each_with_index do |l, j|
  l.each_with_index do |c, i|
    hd[j] ||= {}
    hd[j][i] = c
  end
end

def nbs(d, i,j)
  nbs = []
  nbs << [i-1, j-1] if i.positive? && j.positive?
  nbs << [i, j-1] if j.positive?
  nbs << [i-1,j] if i.positive?
  nbs << [i+1, j+1] if i < d.first.length - 1 && j < d.length - 1
  nbs << [i+1, j] if i < d.first.length - 1
  nbs << [i, j+1] if j < d.length - 1
  nbs << [i-1, j+1] if i.positive? && j < d.length - 1
  nbs << [i+1, j-1] if i < d.first.length - 1 && j.positive?
  nbs
end

100.times do 
  h = {}
  hd.each do |j, l|
    l.each do |i, c|
      cn = 0
      nbs(d, i,j).each do |nb|
        cn += 1 if hd[nb.last][nb.first] == '#'
      end
      h[j] ||= {}
      if c == '#' && [2,3].include?(cn)
        h[j][i] = '#'
      elsif c == '#'
        h[j][i] = '.'
      elsif c == '.' && cn == 3
        h[j][i] = '#'
      else
        h[j][i] = '.'
      end
    end
  end
  hd = h
end

p "Part1: #{hd.values.map { |hv| hv.values }.flatten.count('#')}"

hd = {}
d.each_with_index do |l, j|
  l.each_with_index do |c, i|
    hd[j] ||= {}
    hd[j][i] = c
  end
end

100.times do 
  hd[0][0] = '#'
  hd[0][hd[0].keys.max] = '#'
  hd[hd.keys.max][hd[0].keys.max] = '#'
  hd[hd.keys.max][0] = '#'
  h = {}
  hd.each do |j, l|
    l.each do |i, c|
      cn = 0
      nbs(d, i,j).each do |nb|
        cn += 1 if hd[nb.last][nb.first] == '#'
      end
      h[j] ||= {}
      if c == '#' && [2,3].include?(cn)
        h[j][i] = '#'
      elsif c == '#'
        h[j][i] = '.'
      elsif c == '.' && cn == 3
        h[j][i] = '#'
      else
        h[j][i] = '.'
      end
    end
  end
  hd = h
  hd[0][0] = '#'
  hd[0][hd[0].keys.max] = '#'
  hd[hd.keys.max][hd[0].keys.max] = '#'
  hd[hd.keys.max][0] = '#'
end

p "Part2: #{hd.values.map { |hv| hv.values }.flatten.count('#')}"