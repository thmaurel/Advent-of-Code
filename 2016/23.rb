# Found a way to transform N operations -1 into 1 operations -N, then implemented it

[7, 12].each_with_index do |n, j|
  d = open('23.txt').read.split("\n")
  reg = { 'a' => n}
  i = 0
  while true
    ins = d[i]

    if ins == "jnz c -2" && d[i-1] == "dec c" && d[i-2] == "inc a"
      reg["a"] += reg["c"]
      reg["c"] = 0
    end

    if d[i-5..i] == ["cpy b c", "inc a", "dec c", "jnz c -2", "dec d", "jnz d -5"]
      reg["a"] += reg["d"] * reg["b"]
      reg["c"] = 0
      reg["d"] = 0
    end

    case ins.split.first
    when "cpy"
      x = ins.split[1]
      y = ins.split.last
      reg[y] ||= 0
      reg[y] = (x.match?(/\d+/) ? x.to_i : reg[x])
    when "inc"
      x = ins.split.last
      reg[x] ||= 0
      reg[x] += 1
    when "dec"
      x = ins.split.last
      reg[x] ||= 0
      reg[x] -= 1
    when "jnz"
      x = ins.split[1].match?(/\d+/) ? ins.split[1].to_i : ( reg[ins.split[1]] || 0)
      y = ins.split.last.match?(/\d+/) ? ins.split.last.to_i : (reg[ins.split.last] || 0)
      i += y - 1 unless x.zero?
    when "tgl"
      x = i + (ins.split.last.match?(/\d+/) ? ins.split.last.to_i : (reg[ins.split.last] || 0))
      if x.negative? || d[x].nil?

      elsif d[x].split.length == 2
        if d[x].split.first == "inc"
          d[x].gsub!("inc", "dec")
        else
          d[x].gsub!(d[x].split.first, "inc")
        end
      else
        if d[x].split.first == "jnz"
          d[x].gsub!("jnz", "cpy")
        else
          d[x].gsub!(d[x].split.first, "jnz")
        end
      end
    end
    i += 1
    break if i >= d.length
  end

  p "Part#{j+1}: #{reg['a']}"
end
