require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

rs = d[0..19].map do |ct|
  ct.split(": ").last.split(" or ").map{|x| (x.split("-").map(&:to_i).first..x.split("-").map(&:to_i).last)}
end.flatten

vt = d[24..-1].select do |ts|
  valid = true
  ts.split(";").each do |v|
    vf = false
    rs.each do |rg|
      vf = true if rg.include?(v.to_i)
    end
    valid = false unless vf
  end
  valid
end

# p vt

rgs = d[0..19].map do |ct|
  ct.split(": ").last.split(" or ").map{|x| (x.split("-").map(&:to_i).first..x.split("-").map(&:to_i).last)}
end

# p rgs

# p vt.map{|x| x.split(";").first.to_i}
h = {}

infinite = false
change = false
toto = true
15.times do |k|
  tmp = {}
  p "Iteration ##{k+1}"
  change = false
  for i in (0..19)
    ll = rgs.select do |rg|
      valid = true
      vt.map{|x| x.split(";")[i].to_i}.each do |v|
        valid = false unless (rg.first.include?(v) || rg.last.include?(v))
      end
      valid && !h.values.include?(rg)
    end
    # p "LL"if ll.length == 2
    # p ll if ll.length == 2
    # print "pour i = " if ll.length == 2
    # p i if ll.length == 2
    print "#{ll.length} "
    p "pouet" if i == 16 && ll.length == 2
    p ll if i == 16 && ll.length == 2
    p "pouet" if i == 19 && ll.length == 2
    p ll if i == 19 && ll.length == 2
    unless h.key?(i)
      tmp[i] = ll
      if k == 8 && ll.length == 2 && toto
        toto = false
        h[i] = ll.last
      end
      if i == 19 && ll.length == 2
        h[i] = ll.first
      end
      h[i] = ll.first if ll.length == 1
      change = true if ll.length == 1
      # if infinite && ll.length == 2
      #   h[i] = ll.last
      # end
      # print "\n#{i} was the one to be checked\n" if ll.length == 1
      # p ll if ll.length == 1
    end
  end
  infinite = true if change == false
  print "\n"
  # p tmp.values.flatten(1) if k == 3
  val = nil
  key = nil
  tmp.values.flatten(1).each do |v|
    val = v if tmp.values.flatten(1).count(v) == 1
  end
  tmp.each do |k,v|
    key = k if val && v.include?(val)
  end
  h[key] = val if key && val
  # p h
  # p h.values
end

p h.values.uniq == h.values
p h.keys.sort
p h.length
p "wesh"

# 1705912046921

p(h.select do |k,v|
  c = v == [48..885, 906..949] || v == [28..420, 431..970] || v == [45..112, 129..967]
  d = v == [41..447, 459..956] || v == [36..913, 934..962] || v == [34..792, 815..952]
  c || d
end)

ff = %w(7 10 19 16 13 17).map(&:to_i)
sum = 1
arr = [163, 151, 149, 67, 71, 79, 109, 61, 83, 137, 89, 59, 53, 179, 73, 157, 139, 173, 131, 167]
ff.each do |i|
  sum = sum * arr[i]
end

p sum
