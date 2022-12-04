t = open("3.txt").read
h = {}
h[[0,0]] = 1
x = 0
y = 0
xr = 0
yr = 0
t.split("").each_with_index do |n, i|
  if i.even?
    case n
    when ">" then x += 1
    when "<" then x -= 1
    when "v" then y -= 1
    when "^" then y += 1
    end
    if h[[x,y]]
      h[[x,y]] += 1
    else
      h[[x,y]] = 1
    end
  else
    case n
    when ">" then xr += 1
    when "<" then xr -= 1
    when "v" then yr -= 1
    when "^" then yr += 1
    end
    if h[[xr,yr]]
      h[[xr,yr]] += 1
    else
      h[[xr,yr]] = 1
    end
  end
end

p h.keys.count
