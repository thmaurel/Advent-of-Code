require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten.map{|x| x.split('')}

def occupied(i,j,mat,i_dir, j_dir)
  while true
    if mat[j + j_dir].nil?
      return false
    elsif mat[j + j_dir][i + i_dir].nil?
      return false
    elsif mat[j + j_dir][i + i_dir] == '#'
      return true
    elsif mat[j + j_dir][i + i_dir] == 'L'
      return false
    elsif mat[j + j_dir][i + i_dir] == '.'
      i_dir += i_dir
      j_dir += j_dir
    elsif mat[j + j_dir][i + i_dir] == 'b'
      return false
    end
  end
end

def occupieds(i,j,mat)
  c = 0
  c += 1 if occupied(i,j,mat, 0, 1)
  c += 1 if occupied(i,j,mat, 1, 0)
  c += 1 if occupied(i,j,mat, 1, 1)
  c += 1 if occupied(i,j,mat, -1, -1)
  c += 1 if occupied(i,j,mat, 0, -1)
  c += 1 if occupied(i,j,mat, -1, 0)
  c += 1 if occupied(i,j,mat, -1, 1)
  c += 1 if occupied(i,j,mat, 1, -1)
  return c
end


bs = []
91.times do
  bs << "b"
end

d << bs

bs = []
91.times do
  bs << "b"
end
d.insert(0, bs)


d.each_with_index do |x,i|
  d[i].insert(0, "b")
  d[i].insert(-1, "b")
end

compt = 1
while true
  p "Iteration ##{compt}" if compt % 1000 == 0
  res = []
  96.times do
    tmp = []
    93.times do
      tmp << ""
    end
    res << tmp
  end

  d.each_with_index do |y, j|
    y.each_with_index do |x,i|
      res[j][i] = "." if x == "."
      res[j][i] = 'b' if x == 'b'
      if x == 'L'
        # rien d'occupé autour, deviens occupé
        if occupieds(i,j,d) == 0
          res[j][i] = '#'
        else
          res[j][i] = 'L'
        end
        # sinon reste vide
      elsif x == '#'
        if occupieds(i,j,d) >= 4
          res[j][i] = 'L'
        else
          res[j][i] = '#'
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


