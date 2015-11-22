require 'pry'

word = "In the Czech Republic, the most valuable area is protected in the Sumava National Park and Protected Landscape and the UNESCO Biosphere Reserve. Part of the German section is protected as the Bavarian Forest National Park. The Bohemian Forest is a popular holiday destination because it is excellent ".bytes
xor = File.read("xor").bytes

puts xor.zip(word).map { |a,b| a ^ b }.pack("c*")
puts word.length
