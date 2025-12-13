d = open('18.txt').read.split("\n")

reg = {}
snds = []
i = 0
while true
  l = d[i]
  x = l.split[1]
  y = l.split.last
  reg[x] ||= 0
  reg[y] ||= 0
  case l.split.first
  when 'set'
    reg[x] = y.match?(/\d+/) ? y.to_i : reg[y]
  when 'snd'
    snds << reg[y]
  when 'add'
    reg[x] += (y.match?(/\d+/) ? y.to_i : reg[y])
  when 'mul'
    reg[x] *= (y.match?(/\d+/) ? y.to_i : reg[y])
  when 'mod'
    reg[x] %= (y.match?(/\d+/) ? y.to_i : reg[y])
  when 'rcv'
    if !(x.match?(/\d+/) ? x.to_i : reg[x]).zero?
      p "Part1: #{snds.last}"
      break
    end
  when 'jgz'
    if (x.match?(/\d+/) ? x.to_i : reg[x]).positive?
      i += (y.match?(/\d+/) ? y.to_i : reg[y]) - 1
    end
  end
  i += 1
end
