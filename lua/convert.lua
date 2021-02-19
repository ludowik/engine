local __floor = math.floor
local __format, __byte = string.format, string.byte

function tointeger(number)
    return __floor(tonumber(number) or 0)
end

function toboolean(v)
    return v == 'true' and true or false
end

function tocolor(v)
    local r, g, b, a = v:match('r=(%d+), g=(%d+), b=(%d+), a=(%d+)')
    return color(
        tonumber(r),
        tonumber(g),
        tonumber(b),
        tonumber(a))
end

function format(value)
    if type(value) == 'number' then
        return formatNumber(value)
    end
    return tostring(value)
end

function formatNumber(number)
    local s = __format('%.6f', number)
    local len = s:len()
    for i=len,1,-1 do
        if s:byte(i) ~= __byte('0') then
            break
        end
        len = len-1
    end
    if s:byte(len) == __byte('.') then
        len = len - 1
    end
    return s:left(len)
end

function formatInteger(number)
    return __format('%d', number)
end

function formatPercent(number)
    return __format('%.1f%%', number * 100)
end

unitsMemory = {'o', 'ko', 'mo', 'go', 'to'}

function convertMemory(size, index)
    if size == nil then return '?' end

    index = index or 1
    while size >= 1024 and index < #unitsMemory do
        size = size / 1024
        index = index + 1
    end
    return __format('%.1f', size)..' '..unitsMemory[index]
end

unitsNumber = {'', 'milliers', 'millions', 'milliards', 'billion', 'billiard'}

function convertNumber(number)
    local index = 1
    while number >= 1000 and index < #unitsNumber do
        number = number / 1000
        index = index + 1
    end
    return __format('%.2f', number)..' '..unitsNumber[index]
end
