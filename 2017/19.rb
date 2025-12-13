# The break condition is based on input observation

d = open('19.txt').read.split("\n").map{|x| x.split('')}

s = nil
d.each_with_index do |l, j|
  l.each_with_index do |c, i|
    s = [i, 0] if j.zero? && c == '|'
  end
end

dir = 's'
pos = s
path = []
c = 0
while true
  i = pos.first
  j = pos.last
  c += 1
  path << d[j][i] if d[j][i].match?(/\w/)
  break if d[j][i] == 'K' # This is because it's the last place on the input
  case dir
  when 's'
    if d[j][i] == '+'
      if d[j+1] && (d[j+1][i] == '|' || d[j+1][i]&.match?(/\w/))
        pos = [i, j + 1]
      elsif i.positive? && (d[j][i - 1] == '-' || d[j][i - 1]&.match?(/\w/))
        pos = [i - 1, j]
        dir = 'w'
      elsif d[j][i + 1] == '-' || d[j][i + 1]&.match?(/\w/)
        pos = [i + 1, j]
        dir = 'e'
      end
    else
      pos = [i, j + 1]
    end
  when 'n'
    if d[j][i] == '+'
      if j.positive? && (d[j - 1][i] == '|' || d[j - 1][i]&.match?(/\w/))
        pos = [i, j - 1]
      elsif i.positive? && (d[j][i - 1] == '-' || d[j][i - 1]&.match?(/\w/))
        pos = [i - 1, j]
        dir = 'w'
      elsif d[j][i + 1] == '-' || d[j][i + 1]&.match?(/\w/)
        pos = [i + 1, j]
        dir = 'e'
      end
    else
      pos = [i, j - 1]
    end
  when 'e'
    if d[j][i] == '+'
      if d[j][i + 1] && (d[j][i + 1] == '-' || d[j][i + 1]&.match?(/\w/))
        pos = [i + 1, j]
      elsif j.positive? && (d[j - 1][i] == '|' || d[j - 1][i]&.match?(/\w/))
        pos = [i, j - 1]
        dir = 'n'
      elsif d[j + 1] && (d[j + 1][i] == '|' || d[j + 1][i]&.match?(/\w/))
        pos = [i, j + 1]
        dir = 's'
      end
    else
      pos = [i + 1, j]
    end
  when 'w'
    if d[j][i] == '+'
      if i.positive? && (d[j][i - 1] == '-' || d[j][i - 1]&.match?(/\w/))
        pos = [i - 1, j]
      elsif j.positive? && (d[j - 1][i] == '|' || d[j - 1][i]&.match?(/\w/))
        pos = [i, j - 1]
        dir = 'n'
      elsif d[j + 1] && (d[j + 1][i] == '|' || d[j + 1][i]&.match?(/\w/))
        pos = [i, j + 1]
        dir = 's'
      end
    else
      pos = [i - 1, j]
    end
  end
end

p "Part1: #{path.join}"
p "Part2: #{c}"
