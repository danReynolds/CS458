a = File.read("ciphertext1")
b = File.read("ciphertext2")
xor = a.bytes.zip(b.bytes).map { |c,d| c ^ d }.pack("c*")
File.open('xor', 'w') { |f| f.write(xor) }
