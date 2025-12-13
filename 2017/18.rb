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
      puts"Part1: #{snds.last}"
      break
    end
  when 'jgz'
    if (x.match?(/\d+/) ? x.to_i : reg[x]).positive?
      i += (y.match?(/\d+/) ? y.to_i : reg[y]) - 1
    end
  end
  i += 1
end

reg0 = {}
reg0['p'] = 0
reg1 = {}
reg1['p'] = 1

snd0 = []
snd1 = []

c1 = 0

i0 = 0
i1 = 0
while true
  wait = false
  l = d[i0]
  x = l.split[1]
  y = l.split.last
  reg0[x] ||= 0
  reg0[y] ||= 0
  case l.split.first
  when 'set'
    reg0[x] = y.match?(/\d+/) ? y.to_i : reg0[y]
  when 'snd'
    snd0 << reg0[y]
  when 'add'
    reg0[x] += (y.match?(/\d+/) ? y.to_i : reg0[y])
  when 'mul'
    reg0[x] *= (y.match?(/\d+/) ? y.to_i : reg0[y])
  when 'mod'
    reg0[x] %= (y.match?(/\d+/) ? y.to_i : reg0[y])
  when 'rcv'
    if snd1.any?
      reg0[y] = snd1.shift
    else
      wait = true
      i0 -= 1
    end
  when 'jgz'
    if (x.match?(/\d+/) ? x.to_i : reg0[x]).positive?
      i0 += (y.match?(/\d+/) ? y.to_i : reg0[y]) - 1
    end
  end
  i0 += 1

  l = d[i1]
  x = l.split[1]
  y = l.split.last
  reg1[x] ||= 0
  reg1[y] ||= 0
  case l.split.first
  when 'set'
    reg1[x] = y.match?(/\d+/) ? y.to_i : reg1[y]
  when 'snd'
    snd1 << reg1[y]
    c1 += 1
  when 'add'
    reg1[x] += (y.match?(/\d+/) ? y.to_i : reg1[y])
  when 'mul'
    reg1[x] *= (y.match?(/\d+/) ? y.to_i : reg1[y])
  when 'mod'
    reg1[x] %= (y.match?(/\d+/) ? y.to_i : reg1[y])
  when 'rcv'
    if snd0.any?
      reg1[y] = snd0.shift
    else
      if wait
        puts "Part2: #{c1}"
        break
      end
      i1 -= 1
    end
  when 'jgz'
    if (x.match?(/\d+/) ? x.to_i : reg1[x]).positive?
      i1 += (y.match?(/\d+/) ? y.to_i : reg1[y]) - 1
    end
  end
  i1 += 1
end
