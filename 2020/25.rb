require 'csv'
t = Time.now

dpk = 5290733
cpk = 15231938


test = 5764801

v = 1
s = 15231938

(4412859 + 1).times do |i|
  v = v * s
  v = v % 20201227
end
# s = v
p v


# dpk a l'index 4412859
# cpk a l'index 5282489
