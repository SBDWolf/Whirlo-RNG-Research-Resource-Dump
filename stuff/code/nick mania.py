advancementsfile = open("C:/Users/SBDWolf/Desktop/nick advancements.txt", "r")

lines = advancementsfile.readlines()

values_list = []
for line in lines:
    values = line.split("-")
    values_list.append(values[1].replace('\n', ''))

nickfile = open("C:/Users/SBDWolf/Desktop/nickmachine.txt", "r")
nickoutput = open("C:/Users/SBDWolf/Desktop/nickmachineoutput.txt", "w")
nicklines = nickfile.readlines()

for nickline in nicklines:
    nickvalues = nickline.split("New RNG: ")
    hexstring = "0x" + nickvalues[1].replace('\n', '')
    decimal_index = int(hexstring, 16)
    first_advancement = values_list[decimal_index]
    hexstring_again = "0x" + first_advancement
    decimal_index_again = int(hexstring_again, 16)
    newline = nickline.replace('\n', '') + " - Advances to: " + values_list[decimal_index_again] + "\n"
    nickoutput.write(newline)
    

