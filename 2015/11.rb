pw = open("2015/11.txt").read
# pw = '' # Add part 1 result for Part 2

def next_pw(pw)
  letters = ('a'..'z').to_a
  pw[-1] = letters[(letters.index(pw[-1]) + 1) % 26]
  pw[-2] = letters[(letters.index(pw[-2]) + 1) % 26] if pw[-1] == 'a'
  pw[-3] = letters[(letters.index(pw[-3]) + 1) % 26] if pw[-1] == 'a' && pw[-2] == 'a'
  pw[-4] = letters[(letters.index(pw[-4]) + 1) % 26] if pw[-1] == 'a' && pw[-2] == 'a' && pw[-3] == 'a'
  pw[-5] = letters[(letters.index(pw[-5]) + 1) % 26] if pw[-1] == 'a' && pw[-2] == 'a' && pw[-3] == 'a' && pw[-4] == 'a'
  pw[-6] = letters[(letters.index(pw[-6]) + 1) % 26] if pw[-1] == 'a' && pw[-2] == 'a' && pw[-3] == 'a' && pw[-4] == 'a' && pw[-5] == 'a'
  pw[-7] = letters[(letters.index(pw[-7]) + 1) % 26] if pw[-1] == 'a' && pw[-2] == 'a' && pw[-3] == 'a' && pw[-4] == 'a' && pw[-5] == 'a' && pw[-6] == 'a'
  pw[-8] = letters[(letters.index(pw[-8]) + 1) % 26] if pw[-1] == 'a' && pw[-2] == 'a' && pw[-3] == 'a' && pw[-4] == 'a' && pw[-5] == 'a' && pw[-6] == 'a' && pw[-7] == 'a'
  return pw
end

def pw_has_straight(pw)
   %w(abc bcd cde def efg fgh pqr qrs rst stu tuv uvw vwx wxy xyz).each do |tri|
     return true if pw.include?(tri)
   end
   return false
end

def pw_2_pairs(pw)
  c = 0
  %w(aa bb cc dd ee ff gg hh jj kk mm nn pp qq rr ss tt uu vv ww xx yy zz).each do |pa|
    c += 1 if pw.include?(pa)
  end
  return c >= 2
end

in_progress = true

while in_progress
  pw = next_pw(pw)
  if !pw.include?('i') && !pw.include?('o') && !pw.include?('l') && pw_has_straight(pw) && pw_2_pairs(pw)
    in_progress = false
    puts pw
  end
end