d = open("2015/14.txt").read.split("\n")
h = {}

d.each do |l|
  name = l.split(' ').first
  speed = l.split(' ')[3].to_i
  dur = l.split(' ')[6].to_i
  rest = l.split(' ')[-2].to_i
  h[name] = { speed:, dur:, rest: }
end

t = 2503

res = h.map do |k,v|
  dur = v[:dur]
  speed = v[:speed]
  rest = v[:rest]
  n = t / (dur + rest)
  r = t % (dur + rest)
  n * speed * dur + [r, dur].min * speed
end

p "Part 1: #{res.max}"

# Part 2

t.times do |i|
  res = h.map do |k,v|
    dur = v[:dur]
    speed = v[:speed]
    rest = v[:rest]
    n = i / (dur + rest)
    r = i % (dur + rest)
    h[k][:dis] = n * speed * dur + [r, dur].min * speed
  end
  h.each do |k, v|
    h[k][:pts] ||= 0
    h[k][:pts] += 1 if v[:dis] == res.max
  end
end

p "Part 2: #{h.map{|k, v| v[:pts]}.max - 1}"