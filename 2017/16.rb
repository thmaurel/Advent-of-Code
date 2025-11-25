d = open('2017/16.txt').read.strip

tmp = ('a'..'p').to_a
done = []
k = -1
r = nil
while true
  k += 1
  r -= 1 unless r.nil?
  break if !r.nil? && r.zero?
  if done.include?(tmp.join('')) && r.nil?
    r = 1000000000 % k
  end
  done << tmp.join('') unless done.include?(tmp.join(''))
  d.split(',').each do |l|
    x = l[0]
    case x
    when 's'
      n = l[1..-1].to_i
      tmp = (tmp[-n..-1] + tmp[0..-n - 1]).map { |x| x}
    when 'x'
      i = l[1..-1].split('/').first.to_i
      j = l[1..-1].split('/').last.to_i
      a = tmp[i]
      b = tmp[j]
      tmp[i] = b
      tmp[j] = a
    when 'p'
      a = l[1..-1].split('/').first
      b = l[1..-1].split('/').last
      i = tmp.index(a)
      j = tmp.index(b)
      tmp[i] = b
      tmp[j] = a
    end
  end
  p "Part1: #{tmp.join('')}" if k.zero?
end

p "Part2: #{tmp.join('')}"
