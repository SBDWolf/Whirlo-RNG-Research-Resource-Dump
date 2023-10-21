rng = 0x7e005e
left_nick = 0x7e05a8
middle_nick = 0x7e05a4
right_nick = 0x7e05ac
upper_nick = 0x7e05a0
results_filepath = "C:/Users/SBDWolf/Desktop/nick.txt"

function lstate(num)
	path = "C:/Users/SBDWolf/Desktop/Emulators/Bizhawk 2.9.1/SNES/State/whirlo prac v0.1beta.BSNESv115+.QuickSave"..tostring(num)..".State"
	savestate.load(path)
end

function sstate(num)
	path = "C:/Users/SBDWolf/Desktop/Emulators/Bizhawk 2.9.1/SNES/State/whirlo prac v0.1beta.BSNESv115+.QuickSave"..tostring(num)..".State"
	savestate.save(path)
end

function translatenick(value)
    type = ""
    if value == 160 then
        type = "truth     "
    elseif value == 164 then
        type = "beard     "
    elseif value == 168 then
        type = "food      "
    elseif value == 172 then
        type = "instrument"
    else
        type = "unknown   "
    end
    return type
end

function testgroup()
    total_rng_values=256
    file = io.open(results_filepath, "a")
    io.output(file)
    for i=0, total_rng_values-1, 1 do
        lstate(0)
        memory.writebyte(rng, i)
        input=joypad.get()
        input["P1 A"] = true
        joypad.set(input)
        for j=1, 50, 1 do
            emu.frameadvance()
        end
        left = translatenick(memory.readbyte(left_nick))
        middle = translatenick(memory.readbyte(middle_nick))
        right = translatenick(memory.readbyte(right_nick))
        upper = translatenick(memory.readbyte(upper_nick))
        newrng = memory.readbyte(rng)

        io.write("Initial RNG: "..string.format("%02x",i).." - Left: "..left.." - Middle: "..middle.." - Right: "..right.." - Upper: "..upper.." - New RNG: "..string.format("%02x",newrng).."\n")

        -- left = memory.readbyte(left_nick)
        -- middle = memory.readbyte(middle_nick)
        -- right = memory.readbyte(right_nick)
        -- upper = memory.readbyte(upper_nick)

        -- if (left == 160 or middle == 160) then
        --     io.write(string.format("%02x",i).."\n")
        -- end

    end
    io.close(file)
end

client.unpause()
testgroup()
console.log("FINISHED")
