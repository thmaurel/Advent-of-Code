require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

l = d.first
p l
sum = 0
d.each do |l|
  while l.include?('(')
    cl = nil
    opn = nil
    l.split('').each_with_index do |el, i|
      opn = i if el == '(' && cl.nil?
      cl = i if el == ')' && cl.nil?
    end

    p l[opn..cl].gsub(/[()]/, '').split(' ')
    tab = l[opn..cl].gsub(/[()]/, '').split(' ')
    while tab.length > 1
      tab.each_with_index do |t, i|
        if tab.include?("+")
          if t == "+"
            tab[i-1] = tab[i-1].to_i + tab[i+1].to_i
            tab.delete_at(i+1)
            tab.delete_at(i)
          end
        else
          if t == "*"
            tab[i-1] = tab[i-1].to_i * tab[i+1].to_i
            tab.delete_at(i+1)
            tab.delete_at(i)
          end
        end
      end
    end
    # calc = 0
    # op = nil
    # l[opn..cl].gsub(/[()]/, '').split(' ').each_with_index do |n, i|
    #   calc = n.to_i if i.zero?
    #   op = n if ['+', '*'].include?(n)
    #   calc += n.to_i if op == '+' && n.to_i.positive?
    #   calc *= n.to_i if op == '*' && n.to_i.positive?
    #   # p "Op is #{op} and calc is #{calc}, while n is #{n}"
    # end
    l = l[0...opn] + tab.first.to_s + l[(cl + 1)..]

  end
  # calc = 0
  # op = nil
  # l.split(' ').each_with_index do |n, i|
  #   calc = n.to_i if i.zero?
  #   op = n if ['+', '*'].include?(n)
  #   calc += n.to_i if op == '+' && n.to_i.positive?
  #   calc *= n.to_i if op == '*' && n.to_i.positive?
  # end
  tab = l.split(' ')
    while tab.length > 1
      tab.each_with_index do |t, i|
        if tab.include?("+")
          if t == "+"
            tab[i-1] = tab[i-1].to_i + tab[i+1].to_i
            tab.delete_at(i+1)
            tab.delete_at(i)
          end
        else
          if t == "*"
            tab[i-1] = tab[i-1].to_i * tab[i+1].to_i
            tab.delete_at(i+1)
            tab.delete_at(i)
          end
        end
      end
    end
  sum += tab.first
end

p sum


return
# Part 1
# p d.first
sum = 0
# l = d.first
d.each do |l|

  while l.include?("(")
    cl = nil
    opn = nil
    l.split("").each_with_index do |el, i|
      opn = i if el == "(" && cl.nil?
      cl = i if el == ")" && cl.nil?
    end

    # p opn
    # p cl

    # p l[opn..cl].gsub(/[()]/, "")

    calc = 0
    op = nil
    l[opn..cl].gsub(/[()]/, "").split(" ").each_with_index do |n, i|
      calc = n.to_i if i == 0
      op = n if ['+', '*'].include?(n)
      calc = calc + n.to_i if op == '+' && n.to_i > 0
      calc = calc * n.to_i if op == '*' && n.to_i > 0
      # p "Op is #{op} and calc is #{calc}, while n is #{n}"
    end

    p calc

    l = l[0...opn] + calc.to_s + l[(cl + 1)..-1]
    # p l
  end

  p l

  calc = 0
  op = nil
  l.split(" ").each_with_index do |n, i|
    calc = n.to_i if i == 0
    op = n if ['+', '*'].include?(n)
    calc = calc + n.to_i if op == '+' && n.to_i > 0
    calc = calc * n.to_i if op == '*' && n.to_i > 0
    p "Op is #{op} and calc is #{calc}, while n is #{n}"
  end
  sum += calc
end

p sum
