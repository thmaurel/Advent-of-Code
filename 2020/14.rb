require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten


m = {}
mask = ""
d.each do |l|
  if l[0..3] == "mask"
    mask = l.split("= ").last
  else
    v = l.split("= ").last.to_i
    kb =  l.split("[").last.split("]").first.to_i.to_s(2)
    while kb.length < 36
      kb = "0" + kb
    end
    kf = kb.split("").each_with_index.map{|x, i| mask[i] == "0" ? x : mask[i]}.join("")
    tab = [kf]
    tab.each do |k|
      if k.include?("X")
        tf = true
        k0 = "" && k1 = ""
        k.split("").each do |s|
          if s == "X" && tf
            k0 += "0"
            k1 += "1"
            tf = false
          else
            k0 += s
            k1 += s
          end
        end
        tab << k0 << k1
      end
    end
    ads = tab.reject{|x| x.include?("X")}
    ads.each {|x| m[x.to_i(2)] = v}
  end
end

p m.values.sum

# Part 1
# m = {}
# mask = ""
# d.each do |l|
#   if l[0..3] == "mask"
#     mask = l.split("= ").last
#   else
#     v = l.split("= ").last.to_i
#     vb = v.to_s(2)
#     while vb.length < 36
#       vb = "0" + vb
#     end
#     vf = vb.split("").each_with_index.map{|x, i| mask[i] == "X" ? x : mask[i]}.join("").to_i(2)
#     k =  l.split("[").last.split("]").first.to_i
#     m[k] = vf
#   end
# end

# p m.values.sum
