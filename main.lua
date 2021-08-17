#!/usr/bin/env lua

function square(num)
    return num * num
end

function capitalize(str)
    return str:gsub("^%l", string.upper)
end

arr = {avg_and_sum(1, 2, 3, 4, 5)}

io.write("avg_and_sum() = [", arr[1], ", ", arr[2], "]\n")
io.write("square(5) = ", square(5) , "\n")
io.write("capitalize(hello) = ", capitalize("hello"), "\n")

