require 'pry'

word = "In the Czech Republic, the most valuable area is protected in the Sumava National Park and Protected Landscape and the UNESCO Biosphere Reserve. Part of the German section is protected as the Bavarian Forest National Park. The Bohemian Forest is a popular holiday destination because it is excellent ".bytes
xor = File.read("xor").bytes

puts xor.zip(word).map { |a,b| a ^ b }.pack("c*")
puts word.length

#Potton Manor was built in the 1860s. It was requesitioned by the armed forces and used as a laboratory during the war and as a car factory by Eva Pokorova and Otto van Smekal. The Champion car built in Potton was purchased from the National Motor Museum by Potton History Society, whose aim it is to
#In the Czech Republic, the most valuable area is protected in the Sumava National Park and Protected Landscape and the UNESCO Biosphere Reserve. Part of the German section is protected as the Bavarian Forest National Park. The Bohemian Forest is a popular holiday destination because it is excellent 
