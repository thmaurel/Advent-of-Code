require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

d.each_with_index.map {|x, i| ["jmp", "nop"].include?(x[0..2]) ? i : nil}.reject{|x| x.nil?}.each do |ind|
  acc = 0
  i = 0

  is = [0]
  while true
    case d[i][0..2]
    when "acc"
      acc += d[i].split(' ').last.to_i
      i += 1
    when "jmp"
      if i == ind
        i += 1
      else
        i += d[i].split(' ').last.to_i
      end
    else
      if i == ind
        i += d[i].split(' ').last.to_i
      else
        i += 1
      end
    end
    if is.include?(i)
      p acc
      p "c'est cassé"
      break
    end
    if i == d.length
      p "ca marche"
      p acc
      break
    end
    is << i
  end
end
