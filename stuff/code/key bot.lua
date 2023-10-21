rng = 0x7e005e
life_counter = 0x7e0470
results_filepath = "C:/Users/SBDWolf/Desktop/key.txt"

function lstate(num)
	path = "C:/Users/SBDWolf/Desktop/Emulators/Bizhawk 2.9.1/SNES/State/whirlo prac v0.1beta.BSNESv115+.QuickSave"..tostring(num)..".State"
	savestate.load(path)
end

function sstate(num)
	path = "C:/Users/SBDWolf/Desktop/Emulators/Bizhawk 2.9.1/SNES/State/whirlo prac v0.1beta.BSNESv115+.QuickSave"..tostring(num)..".State"
	savestate.save(path)
end

function testgroup()
    total_rng_values=256
    file = io.open(results_filepath, "a")
    io.output(file)
    for i=0, total_rng_values-1, 1 do
        lstate(2)
        memory.writebyte(rng, i)
        for j=1, 290, 1 do
            emu.frameadvance()
        end
        if (memory.readbyte(life_counter) ~= 7) then
            io.write("RNG: "..string.format("%02x",i).." - nope\n")
        else
            io.write("RNG: "..string.format("%02x",i).." - there is a key\n")
        end
    end
    io.close(file)
end

client.unpause()
testgroup()
console.log("FINISHED")
