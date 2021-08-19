#!/usr/bin/env lua

function dump(obj)
    if type(obj) == "table" then
        local str = "{ "

        for key, value in pairs(obj) do
            if type(key) ~= "number" then
                key = '"' .. key .. '"'
            end
            str = str .. "[" .. key .. "] = " .. dump(value) .. ", "
        end
        return str .. "}"
    else
        return tostring(obj)
    end
end

function locals()
    local thread = 2
    local index = 1

    while true do
        local key, value = debug.getlocal(thread, index)

        if key ~= nil then
            io.write(type(value), "\n")
            io.write("\t", key, " = ", dump(value), "\n")
        else
            break
        end
        index = index + 1
    end
end

function fibonacci(n)
    locals()
    if n < 3 then
        return 1
    else
        return fibonacci(n - 1) + fibonacci(n - 2)
    end
end

for n = 1, 7 do
    print("Debugging --------------------------------------------------------")
    io.write("fibonacci(", n, ") = ", fibonacci(n), "\n")
    print("End debugging ----------------------------------------------------")
end

io.write("\n")

local array = {}
array[1] = "david"
array[2] = "elena"

local dict = {}
dict["david"] = "feo"
dict["elena"] = 50

local pi = 3.14
local str = "En un lugar de la mancha"

print("Debugging --------------------------------------------------------")
locals()
print("End debugging ----------------------------------------------------")

