d = open("2015/16.txt").read.split("\n")

res = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}

arr1 = []
arr2 = []
d.each do |l|
  n = l.split(' ')[1].gsub(':', '').to_i
  children = l.match(/children: (\d+)/)[1].to_i if l.match(/children: (\d+)/)
  cats = l.match(/cats: (\d+)/)[1].to_i if l.match(/cats: (\d+)/)
  samoyeds = l.match(/samoyeds: (\d+)/)[1].to_i if l.match(/samoyeds: (\d+)/)
  pomeranians = l.match(/pomeranians: (\d+)/)[1].to_i if l.match(/pomeranians: (\d+)/)
  akitas = l.match(/akitas: (\d+)/)[1].to_i if l.match(/akitas: (\d+)/)
  vizslas = l.match(/vizslas: (\d+)/)[1].to_i if l.match(/vizslas: (\d+)/)
  goldfish = l.match(/goldfish: (\d+)/)[1].to_i if l.match(/goldfish: (\d+)/)
  trees = l.match(/trees: (\d+)/)[1].to_i if l.match(/trees: (\d+)/)
  cars = l.match(/cars: (\d+)/)[1].to_i if l.match(/cars: (\d+)/)
  perfumes = l.match(/perfumes: (\d+)/)[1].to_i if l.match(/perfumes: (\d+)/)
  arr1 << n if (children.nil? || children == res[:children]) && (cats.nil? || cats == res[:cats]) && (samoyeds.nil? || samoyeds == res[:samoyeds]) && (pomeranians.nil? || pomeranians == res[:pomeranians]) && (akitas.nil? || akitas == res[:akitas]) && (vizslas.nil? || vizslas == res[:vizslas]) && (goldfish.nil? || goldfish == res[:goldfish]) && (trees.nil? || trees == res[:trees]) && (cars.nil? || cars == res[:cars]) && (perfumes.nil? || perfumes == res[:perfumes])
  arr2 << n if (children.nil? || children == res[:children]) && (cats.nil? || cats > res[:cats]) && (samoyeds.nil? || samoyeds == res[:samoyeds]) && (pomeranians.nil? || pomeranians < res[:pomeranians]) && (akitas.nil? || akitas == res[:akitas]) && (vizslas.nil? || vizslas == res[:vizslas]) && (goldfish.nil? || goldfish < res[:goldfish]) && (trees.nil? || trees > res[:trees]) && (cars.nil? || cars == res[:cars]) && (perfumes.nil? || perfumes == res[:perfumes])
end

p "Part1: #{arr1.first}"
p "Part2: #{arr2.first}"