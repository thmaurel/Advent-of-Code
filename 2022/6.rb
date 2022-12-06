require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

# p d

a = d.first.split('')[0..13]
d.first.split('').each_with_index do |l, i|
  if i >= 14
    a.delete_at(0)
    a << l
    if a.uniq.size == 14
      p i
      return
    end
  end
end
