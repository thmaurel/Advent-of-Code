require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten.map{|x| x.split('')}


# p d.first.length # 91
# p d.length # 94

d.insert(0, [])
d << []

91.times { d.first << 'bb'}
91.times { d.last << 'bb'}

d.each do |l|
  l.insert(0, 'bb')
  l << 'bb'
end

# ca commence la on a juste foutu des frontieres

def neighbours_free?(d, i, j)
  vs = [
    [1, 1],
    [1, 0],
    [0, 1],
    [-1, -1],
    [-1, 0],
    [0, -1],
    [1, -1],
    [-1, 1]
  ]
  vs.each do |u,v|
    k = 1
    while true
      return false if d[j - (u * k)][i - (v * k)] == '#'
      break if d[j - (u * k)][i - (v * k)] != '.'
      k += 1
    end
  end
  return true
end

def five_or_more?(d, i, j)
  vs = [
    [1, 1],
    [1, 0],
    [0, 1],
    [-1, -1],
    [-1, 0],
    [0, -1],
    [1, -1],
    [-1, 1]
  ]
  c = 0
  vs.each do |u,v|
    k = 1
    while true
      if d[j - (u * k)][i - (v * k)] == '#'
        c += 1
        break
      end
      break if d[j - (u * k)][i - (v * k)] != '.'
      k += 1
    end
  end
  c >= 5
end

compt = 1
while true
  p "Iteration ##{compt}"
  res = []
  96.times do
    tmp = []
    93.times do
      tmp << ""
    end
    res << tmp
  end
  d.each_with_index do |y,j|
    y.each_with_index do |x, i|
      res[j][i] = "." if x == "."
      res[j][i] = "bb" if x == "bb"
      if x == 'L'
        if neighbours_free?(d, i, j)
          res[j][i] = '#'
        else
          res[j][i] = 'L'
        end
      elsif x == '#'
        if five_or_more?(d, i, j)
          res[j][i] = 'L'
        else
          res[j][i] = '#'
        end
      end
    end
  end

  if res == d
    p "GAGNE"
    p res.flatten.count{|x| x == '#'}
    return
  end

  d = res
  compt += 1
end


return
compt = 1
while true
  p "Iteration ##{compt}"
  res = []
  94.times do
    tmp = []
    91.times do
      tmp << ""
    end
    res << tmp
  end

  d.each_with_index do |y, j|
    y.each_with_index do |x,i|
      res[j][i] = "." if x == "."
      if x == 'L'
        # rien d'occupé autour, deviens occupé
        if j == 0 && i == 0 && d[0][1] != "#" && (d[0][1] == 'L' || d[1][2] == 'L' || (d[1][2] == '.' && d[2][3] == 'L')) && d[1][0] != "#" && (d[1][0] == 'L' || d[2][1] == 'L' || (d[2][1] == '.' && d[3][2] == 'L')) && d[1][1] != "#" && (d[1][1] == 'L' || d[2][2] == 'L' || (d[2][2] == '.' && d[3][3] == 'L'))
          res[j][i] = "#"
        elsif i == 0 && d[j-1][0] != '#' && d[j-1][1] != '#' && d[j][1] != '#' && (d[j+1].nil? || (d[j+1][0] != '#' && d[j+1][1] != '#'))
          res[j][i] = "#"
        elsif j == 0 && d[0][i-1] != '#' && d[1][i-1] != '#' && d[1][i] != '#' && (d[0][i+1].nil? || (d[0][i+1] != '#' && d[1][i+1] != '#'))
          res[j][i] = "#"
        elsif i != 0 && j != 0 && d[j-1][i-1] != '#' && d[j-1][i] != '#' && (d[j][i+1].nil? || (d[j-1][i+1] != '#' && d[j][i+1] != '#')) && d[j][i-1] != '#' && (d[j+1].nil? || (d[j+1][i-1] != '#' && d[j+1][i] != '#')) && (d[j+1].nil? || d[j+1][i+1].nil? || (d[j+1][i+1] != '#'))
          res[j][i] = "#"
        else
        # sinon reste vide
          res[j][i] = "L"
        end
      elsif x == '#'
        a = [
          [(i.zero? || j.zero?) ? '.' : d[j-1][i-1], j.zero? ? '.' : d[j-1][i], j.zero? ? '.' : d[j-1][i+1]],
          [i.zero? ? '.' : d[j][i-1], '.', d[j][i+1]],
          [i.zero? ? '.' : (d[j+1].nil? ? '.' : d[j+1][i-1]), d[j+1].nil? ? '.' : d[j+1][i], d[j+1].nil? ? '.' : d[j+1][i+1]]
        ]
        if a.flatten.count{|x| x == '#'} >= 4
          res[j][i] = "L"
        else
          res[j][i] = "#"
        end
        # 4 ou plus autour occupé => deviens vide
        # sinon, reste occupé
      end
    end
  end

  if res == d
    p "GAGNE"
    p res.flatten.count{|x| x == '#'}
    return
  end

  d = res
  compt += 1
end
