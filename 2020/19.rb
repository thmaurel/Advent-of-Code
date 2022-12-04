require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

# p d[0..134]

# 0: 4 1 5
# 1: 2 3 | 3 2
# 2: 4 4 | 5 5
# 3: 4 5 | 5 4
# 4: 'a'
# 5: 'b'

h = {}

20.times do |k|
  d[0..134].each do |r|
    unless h.key?(r.split(': ').first.to_i)
      h[r.split(': ').first.to_i] = r.split(": ").last.gsub("'", '') if r.split(": ").last[0] == "'"
      if r.include?('|')
        conditions = r.split(": ").last.split(' | ')
        res = []
        conditions.each do |condition|
          vor = ['']
          condition.split(' ').each do |rule|
            tmp = []
            fn = []
            if h.key?(rule.to_i)
              if h[rule.to_i].class == Array
                vor.each do |vv|
                  h[rule.to_i].each do |tt|
                    fn << vv + tt
                  end
                end
                vor = fn
              else
                vor.map!{|x| x + h[rule.to_i]}
              end
            else
              res << nil
            end
          end
          res << vor
        end
        # p conditions
        h[r.split(': ').first.to_i] = res.flatten unless res.flatten.include?(nil)
      else
        res = []
        vor = ['']
        r.split(": ").last.split(' ').each do |rule|
          tmp = []
          fn = []
          if h.key?(rule.to_i)
            if h[rule.to_i].class == Array
              vor.each do |vv|
                h[rule.to_i].each do |tt|
                  fn << vv + tt
                end
              end
              vor = fn
            else
              vor.map!{|x| x + h[rule.to_i]}
            end
          else
            res << nil
          end
        end
        res << vor
        h[r.split(': ').first.to_i] = res.flatten unless res.flatten.include?(nil)
      end
    end
  end
end
p h[42].any?
p h[31].any?

# sum = 0
# d[135..573].each do |msg|
#   sum += 1 if h[0].include?(msg)
# end

p d[135]
sum = 0
d[134..575].each do |msg|
  t = 0
  u = 0
  30.times do
    h[42].each do |l|
      while msg[0..l.length - 1] == l
        msg[0..l.length - 1] = ""
        t += 1
      end
    end
  end
  30.times do
    h[31].each do |l|
      while msg[0..l.length - 1] == l
        msg[0..l.length - 1] = ""
        u += 1
      end
    end
  end
  sum += 1 if msg == "" && t >= 2 && u >= 1 && t > u
end
p sum

p "it took #{Time.now - t}s"

# 0: 8 11

# 8: 42
# 11: 42 31

# 8: 42 | 42 8
# 11: 42 31 | 42 11 31



# 0: 42 42 31
# 0: 42 42 42 42 42 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 31


# 288 .. 394
# - 359
