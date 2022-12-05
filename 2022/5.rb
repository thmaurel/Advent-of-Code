require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

h = {}
h[1] = %w(G T R W)
h[2] = %w(G C H P M S V W)
h[3] = %w(C L T S G M)
h[4] = %w(J H D M W R F)
h[5] = %w(P Q L H S W F J)
h[6] = %w(P J D N F M S)
h[7] = %w(Z B D F G C S J)
h[8] = %w(R T B)
h[9] = %w(H N W L C)

d.each do |i|
  n = i.split(" ")[1].to_i
  ds = i.split(" ")[3].to_i
  as = i.split(" ")[5].to_i
  n.times do |i|
    # h[as] << h[ds][-1]
    # h[ds].delete_at(-1)
    h[as] << h[ds][-n + i]
    h[ds].delete_at(-n +i)
  end
end

p h.values.map(&:last).join('')










#     [W]         [J]     [J]
#     [V]     [F] [F] [S] [S]
#     [S] [M] [R] [W] [M] [C]
#     [M] [G] [W] [S] [F] [G]     [C]
# [W] [P] [S] [M] [H] [N] [F]     [L]
# [R] [H] [T] [D] [L] [D] [D] [B] [W]
# [T] [C] [L] [H] [Q] [J] [B] [T] [N]
# [G] [G] [C] [J] [P] [P] [Z] [R] [H]
#  1   2   3   4   5   6   7   8   9
