# takes a very long time

d = open('9.txt').read.split("\n")

ts = []
d.each_with_index do |l, i|
  ts << [l.split(',').first.to_i, l.split(',').last.to_i]
end
max = 0
ts.each do |t|
  ts.each do |tt|
    a = (t.first - tt.first).abs + 1
    b = (t.last - tt.last).abs + 1
    max = a * b if a * b > max
  end
end

p "Part1: #{max}"

ves = {}
hes = {}
ts.each_with_index do |t, n|
  if t.first == ts[(n + 1) % ts.length].first
    ves[t.first] ||= []
    ves[t.first] << (t.last > ts[(n + 1) % ts.length].last ? (ts[(n + 1) % ts.length].last..t.last) : (t.last..ts[(n + 1) % ts.length].last))
  else
    hes[t.last] ||= []
    hes[t.last] << (t.first > ts[(n + 1) % ts.length].first ? (ts[(n + 1) % ts.length].first..t.first) : (t.first..ts[(n + 1) % ts.length].first))
  end
end

max = 0
ts.each_with_index do |t, i|
  ts[i+1..-1].each do |tt|
    a = (t.first - tt.first).abs + 1
    b = (t.last - tt.last).abs + 1
    next if t == tt
    next if a * b <= max

    ve1 = []
    ve2 = []
    he1 = []
    he2 = []
    ((tt.first - t.first).abs - 1).times do |k|
      he1 << [t.first < tt.first ? tt.first - k - 1 : tt.first + k + 1, t.last]
      he2 << [t.first < tt.first ? tt.first - k - 1 : tt.first + k + 1, tt.last]
    end
    ((tt.last - t.last).abs - 1).times do |k|
      ve1 << [t.first, t.last < tt.last ? tt.last - k - 1 : tt.last + k + 1]
      ve2 << [tt.first, t.last < tt.last ? tt.last - k - 1 : tt.last + k + 1]
    end

    ok = true
    he1.each do |pt|
      next unless ves[pt.first]

      ves[pt.first].each do |ve|
        ok = false if ve.include?(pt.last)
      end
      break unless ok
    end
    next unless ok

    he2.each do |pt|
      next unless ves[pt.first]

      ves[pt.first].each do |ve|
        ok = false if ve.include?(pt.last)
      end
      break unless ok
    end
    next unless ok

    ve1.each do |pt|
      next unless hes[pt.last]

      hes[pt.last].each do |he|
        ok = false if he.include?(pt.first)
      end
      break unless ok
    end
    next unless ok

    ve2.each do |pt|
      next unless hes[pt.last]

      hes[pt.last].each do |he|
        ok = false if he.include?(pt.first)
      end
      break unless ok
    end
    next unless ok

    max = a * b if a * b > max
  end
end

p "Part2: #{max}"
