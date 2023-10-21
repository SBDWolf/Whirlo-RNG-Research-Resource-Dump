rng = 0x7e005e
results_filepath = "C:/Users/SBDWolf/Desktop/nick advancements.txt"

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
        lstate(9)
        memory.writebyte(rng, i)
        input=joypad.get()
        input["P1 A"] = true
        joypad.set(input)
        for j=1, 50, 1 do
            emu.frameadvance()
        end
        newrng = memory.readbyte(rng)

        io.write("Initial RNG: "..string.format("%02x",i).."-"..string.format("%02x",newrng).."\n")
    end
    io.close(file)
end

client.unpause()
testgroup()
console.log("FINISHED")
