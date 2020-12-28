function tointeger(number)
    return floor(tonumber(number) or 0)
end

function toboolean(v)
    return v == 'true' and true or false
end

function tocolor(v)
    local r, g, b, a = v:match('r=(%d+), g=(%d+), b=(%d+), a=(%d+)')
    return color(tonumber(r), tonumber(g), tonumber(b), tonumber(a))
end

unitsMemory = {'o', 'ko', 'mo', 'go', 'to'}

function convertMemory(size)
    local index = 1
    while size >= 1024 and index < #unitsMemory do
        size = size / 1024
        index = index + 1
    end
    return string.format('%.2f', size)..' '..unitsMemory[index]
end

unitsNumber = {'', 'milliers', 'millions', 'milliards', 'billion', 'billiard'}

function convertNumber(number)
    local index = 1
    while number >= 1000 and index < #unitsNumber do
        number = number / 1000
        index = index + 1
    end
    return string.format('%.2f', number)..' '..unitsNumber[index]
end

function convertInteger(nb)
    return string.format('%d', nb)
end

function format(value)
    if type(value) == 'number' then
        return formatNumber(value)
    end
    return tostring(value)
end

function formatNumber(number)
    local s = string.format('%.6f', number)
    local len = s:len()
    for i=len,1,-1 do
        if s:byte(i) ~= string.byte('0') then
            break
        end
        len = len-1
    end
    if s:byte(len) == string.byte('.') then
        len = len - 1
    end
    return s:left(len)
end
