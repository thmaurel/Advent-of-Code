d = open('10.txt').read.split("\n")

res = 0

def nbs(f, btns)
  res = btns.map do |btn|
    tmp = f.dup
    btn.each {|i| tmp[i] = tmp[i] == '.' ? '#' : '.'}
    tmp
  end
  res
end

d.each_with_index do |l, i|
  il = l.split(' ').first[1..-2]

  btns = l.split(' ')[1..-2].map{|x| x[1..-2].split(',').map(&:to_i)}

  s = '.' * il.length

  q = [s]
  v = {}
  dis = {}
  dis[s] = 0
  v[s] = true
  f = nil
  while q.any?
    f = q.shift

    if f == il
      break
    end
    nbs(f, btns).each do |nb|
      next if v[nb]

      q << nb
      v[nb] = true
      dis[nb] = dis[f] + 1
    end
  end
  res += dis[f]
end

p res
