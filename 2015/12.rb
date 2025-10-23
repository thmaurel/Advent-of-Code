require 'json'

d = open("2015/12.txt").read
json = JSON.parse(d)

# Part 1
q = [json]
sum = 0

until q.empty?
  f = q.shift
  if f.class == Array
    q += f
  elsif f.class == Hash
    q += f.keys
    q += f.values
  else
    sum += f.to_i
  end
end

p "Part 1: #{sum}"

# Part 2
q = [json]
sum = 0

until q.empty?
  f = q.shift
  if f.class == Array
    q += f
  elsif f.class == Hash
    if !f.keys.include?('red') && !f.values.include?('red')
      q += f.keys
      q += f.values
    end
  else
    sum += f.to_i
  end
end

p "Part 2: #{sum}"