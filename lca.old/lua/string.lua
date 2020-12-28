NL = '\n'

function string.replace(s, from, to)
    return s:gsub(from, to)
end

function string.inList(s, ...)
    for i,v in ipairs({...}) do
        if s == v then
            return true
        end
    end
    return false
end

function string.contains(s, ...)
    for i,v in ipairs({...}) do
        if s:find(v) then
            return true
        end
    end
    return false
end

function string.startWith(s, txt)
    return s:sub(1, #txt) == txt and true or false
end

function string.split(s, delimiter_, trim)
    trim = trim == nil and true or trim

    local result = Table and Table() or {}
    local delimiter = delimiter_ or ","
    if delimiter == '.' then
        delimiter = '%.'
    end
    for match in (s..delimiter_):gmatch("(.-)"..delimiter) do
        if trim then
            match = match:trim()
        end
        table.insert(result, match)
    end
    return result
end

function string.trim(s)
    while string.find(s,"  ") do
        s = string.gsub(s,"  "," ")
    end
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

function string.findLast(s, txt)
    s = s:reverse()
    local i = s:find(txt:reverse())
    return s:len() - i + 1
end

function string.left(s, n)
    return s:sub(1, n)
end

function string.mid(s, i, n)
    return s:sub(i, i+n-1)
end

function string.right(s, n)
    return s:sub(-n)
end

function string.proper(s)
    s = s:sub(1, 1):upper() .. s:sub(2):lower()
    return s
end

function string.trim(s)
    while string.find(s,"  ") do
        s = string.gsub(s,"  "," ")
    end
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

function string.join(tab, delimiter)
    local result = ""
    for i,s in ipairs(tab) do
        result = result..tostring(s)..delimiter
    end
    return result
end

function string.tab(level)
    local str = ''
    for i=1,level do
        str = str..'    '
    end
    return str
end
