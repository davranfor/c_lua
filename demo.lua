#!/usr/bin/env lua

function square(num)
    return num * num
end

arr = {foo(1, 2, 3, 4, 5)}

io.write("calling foo() returns (", arr[1], ", ", arr[2], ")\n")
io.write("square(5) = ", square(5) ,"\n")

--[[
local count = 0

while true do
    local line = io.read()

    if line == nil or line == "quit" then
        break
    end
    io.write(count, ") ", line, "\n")
    count = count + 1
end
--]]

