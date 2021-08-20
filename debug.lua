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

