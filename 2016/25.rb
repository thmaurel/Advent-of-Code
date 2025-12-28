d = open('25.txt').read.split("\n")

a = 0
res = nil
while true
  reg = {
    'a' => a,
    'b' => 0,
    'c' => 0,
    'd' => 0
  }

  signal = []
  i = 0
  while true
    ins = d[i]
    case ins.split.first
    when "cpy"
      x = ins.split[1]
      y = ins.split.last
      reg[y] ||= 0
      reg[y] = (x.match?(/\d+/) ? x.to_i : reg[x])
    when "inc"
      x = ins.split.last
      reg[x] ||= 0
      reg[x] += 1
    when "dec"
      x = ins.split.last
      reg[x] ||= 0
      reg[x] -= 1
    when "jnz"
      x = ins.split[1].match?(/\d+/) ? ins.split[1].to_i : reg[ins.split[1]]
      y = ins.split.last.match?(/\d+/) ? ins.split.last.to_i : reg[ins.split.last]
      i += y - 1 unless x.zero?
    when "out"
      x = ins.split[1].match?(/\d+/) ? ins.split[1].to_i : reg[ins.split[1]]
      break if signal.empty? && x != 0
      break if signal.any? && signal.last + x != 1
      signal << x
      if signal.length == 20
        res = a
        break
      end
    end
    i += 1
    break if (i >= d.length || i.negative?)
  end
  break if res
  a += 1
end

p "Part1: #{res}"
