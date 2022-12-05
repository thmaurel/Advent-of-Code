data = open("7.txt").read


# def binary(number)
#   i = number
#   ns = []
#   while i > 0
#     ns << i % 2
#     i = i / 2
#   end
#   return ns.reverse.join
# end

h = {}
h ['1'] = 1

ns = %w(1 2 3 4 5 6 7 8 9 0)

p ns

200.times do
  # p 'to'
  data.split("\n").each do |line|
    # p line if line == 'b RSHIFT 2 -> d'
    l = line.split(" -> ")
    name = l.last
    comb = l.first
    unless h[name]
      if comb.split(" ").length == 1
        if (comb.split('') & ns).any?
          h[name] = comb.to_i
        else
          h[name] = h[comb] if h[comb]
        end
      elsif comb.split(" ").first == "NOT"
        t = comb.split(" ").last
        if h[t]
          s = h[t].to_s(2)
          (16 - s.length).times { s = '0' + s}
          v = s.split('').map{|vv| vv.to_i.zero? ? '1' : '0'}.join('')
          h[name] = v.to_i(2)
        end
      elsif comb.split(' ')[1] == 'RSHIFT'
        # b RSHIFT 2 -> d
        a = comb.split(' ')[0]
        b = comb.split(' ')[2].to_i
        # p a if (a == 'b' && b == 2)
        if h[a]
          # s = h[a].to_s(2)
          # (16 - s.length).times { s = '0' + s}
          # b.times do
          #   s = '0' + s[0..-2]
          # end
          # h[name] = s.to_i(2)
          h[name] = h[a] >> b
        end
      elsif comb.split(' ')[1] == 'LSHIFT'
        a = comb.split(' ')[0]
        b = comb.split(' ')[2].to_i
        if h[a]
          # s = h[a].to_s(2)
          # (16 - s.length).times { s = '0' + s}
          # b.times do
          #   s = s[1..-1] + '0'
          # end
          # h[name] = s.to_i(2)
          h[name] = h[a] << b
        end
      elsif comb.split(' ')[1] == 'AND'
        a = comb.split(' ')[0]
        b = comb.split(' ')[2]
        if h[a] && h[b]
          sa = h[a].to_s(2)
          sb = h[b].to_s(2)
          (16 - sa.length).times { sa = '0' + sa }
          (16 - sb.length).times { sb = '0' + sb }
          v = ''
          16.times{|u| (sa[u] == '1' && sb[u] == '1') ? (v += '1') : (v += '0')}
          h[name] = v.to_i(2)
        end
      elsif comb.split(' ')[1] == 'OR'
        a = comb.split(' ')[0]
        b = comb.split(' ')[2]
        if h[a] && h[b]
          sa = h[a].to_s(2)
          sb = h[b].to_s(2)
          (16 - sa.length).times { sa = '0' + sa }
          (16 - sb.length).times { sb = '0' + sb }
          v = ''
          16.times{|u| (sa[u] == '1' || sb[u] == '1') ? (v += '1') : (v += '0')}
          h[name] = v.to_i(2)
        end
      end
    end
  end
end
# p h
p h['a']
