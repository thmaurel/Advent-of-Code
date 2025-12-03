d = open('2.txt').read.strip.split(',')

res = 0
d.each do |l|
  a_s = l.split('-').first
  b_s = l.split('-').last
  a = a_s.to_i
  b = b_s.to_i

  ranges = []
  loop do
    max = [b, ('9' * a_s.length).to_i].min
    ranges << [a, max]
    a = max + 1
    a_s = a.to_s
    break if max == b
  end

  ranges.each do |aa, bb|
    n = bb.to_s.length
    done = []
    (1..n/2).to_a.each do |i|
      next if n % i != 0

      m = aa.to_s[0..i-1].to_i
      loop do
        mg = (m.to_s * (n / i)).to_i
        break if mg > b

        if mg >= aa && mg <= bb && !done.include?(mg)
          res += mg
          done << mg
        end
        m += 1
      end
    end
  end
end

p res
