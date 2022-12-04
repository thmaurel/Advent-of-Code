t = open("7.txt").read


def binary(number)
  i = number
  ns = []
  while i > 0
    ns << i % 2
    i = i / 2
  end
  return ns.reverse.join
end

t.split("\n").each do |line|
  l = line.split(" -> ")
  name = l.last
  comb = l.first

end
