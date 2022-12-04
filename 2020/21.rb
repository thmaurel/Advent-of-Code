require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

# class Food
#   def initialize(params = {})
#     @ingredients = params[:ingredients]
#     @allergens = params[:allergens]
#   end
# end

allergens = []
ingredients = []

d.each do |food|
  allergen = food.split(' (contains ').last.gsub(/[) ]/, '').split(';')
  ingredient = food.split(' (contains ').first.split(' ')
  # p allergen
  # p ingredient
  allergens << allergen
  ingredients << ingredient
end
h = {}
allergens.flatten.uniq.each do |al|
  possible_ingredients = []
  allergens.each_with_index do |als, i|
    if als.include?(al)
      possible_ingredients = ingredients[i] if possible_ingredients.empty?
      possible_ingredients = possible_ingredients & ingredients[i] if possible_ingredients.any?
    end
  end
  h[al] = possible_ingredients
end

# p h

res = {}

5.times do
  h.each do |k,v|
    unless res.key?(k)
      calc = v.select{|x| !res.values.include?(x)}
      res[k] = calc.first if calc.length == 1
    end
  end
end
p res
# p res.length
# p allergens.flatten.uniq.length

sum = 0
ingredients.flatten.each do |t|
  sum += 1 unless res.values.include?(t)
end

p sum


tt = []
res.each do |k,v|
  tt << {k => v}
end


p tt
p tt.sort_by{|t| t.keys.first}.map{|u| u.values.first}.join(',')
