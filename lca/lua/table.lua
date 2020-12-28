Table = {}
setmetatable(Table, table)

table.__call = function (_, t)
    t = t or {}
    setmetatable(t, table)
    return t
end

table.__index = table

table.push = table.insert
table.pop = table.remove

function table.add(t, item)
    table.insert(t, item)
    return t
end

function table.addItems(t, items)
    for _,item in ipairs(items) do
        table.insert(t, item)
    end
    return t
end

function table.addKeys(t, items)
    for k,item in pairs(items) do
        t[k] = item
    end
    return t
end

function table:get(i)
    return self[i]
end

function table:set(i, item)
    self[i] = item
    return self, item
end

function table:__add(t)
    local g = Table()
    g:addItems(self)
    g:addItems(t)
    return g
end

function table:clear(value)
    local n = #self
    for i=n,1,-1 do
        self[i] = value -- default is nil
    end
    return self
end

function table.iterator(t)
    return ipairs(t)
end

function table.attribs(t, vars)
    for var,value in pairs(vars) do
        t[var] = value
    end
    return t
end

function table.clone(t)
    -- TODO : écrire une fonction clone
    return table.copy(t)
end

function table.derived(t, mt, override)
    for k,f in pairs(mt) do
        if k ~= 'setup' then
            if type(f) == 'function' and (override or t[k] == nil) then
                t[k] = f
            end
        end
    end
end

local excludeFunctions = {
    'setup',
    'init'
}

function table.push2Global(mt)
    local override = false
    
    local t = _G
    for k,f in pairs(mt) do
        if not k:inList(excludeFunctions) then
            if type(f) == 'function' and (override or t[k] == nil) then
                t[k] = f
            end
        end
    end
end

function table.print(t)
    if t == nil then return end

    print(t)
    for k,v in pairs(t) do
        print(tostring(k)..' = '..tostring(v))
    end
end

function table.indexOf(t, item)
    for i=1,#t do
        if t[i] == item then
            return i
        end
    end
end

function table.first(t, item)
    if item then
        t.currentItem = t[table.indexOf(t, item) or 1]
    else
        t.currentItem = t[1]
    end
    return t.currentItem
end

function table.last(t)
    t.currentItem = t[#t]
    return t.currentItem
end

function table.current(t)
    return t.currentItem or t[1]
end

function table.navigate(t, currentItem, nextIndex, defaultIndex)
    currentItem = currentItem or t.currentItem
    nextIndex = nextIndex or 1
    defaultIndex = defaultIndex or 1

    local nextItem
    if currentItem == nil then
        nextItem = t[defaultIndex]
    else
        if type(currentItem) == 'table' and currentItem.nodes and #currentItem.nodes > 0 then
            nextItem = currentItem.nodes[1]
        else
            t = type(currentItem) == 'table' and currentItem.parent and currentItem.parent.nodes or t
            for i,v in ipairs(t) do
                if v == currentItem then
                    nextItem = t[(i+nextIndex-1)%#t+1] or t[defaultIndex]
                    break
                end
            end
        end
    end

    t.currentItem = nextItem
    return t.currentItem
end

function table.next(t, currentItem)
    return table.navigate(t, currentItem, 1, 1)
end

function table.previous(t, currentItem)
    return table.navigate(t, currentItem, -1, #t)
end

function table:findItem(item, caseInsensitive)
    local n = #self
    for i=1,n do
        local test 
        if caseInsensitive then
            test = self[i]:lower() == item:lower()
        else
            test = self[i] == item 
        end

        if test then
            return i, self[i]
        end
    end
end

function table:removeItem(item)
    local i = table.findItem(self, item)
    if i then
        table.remove(self, i)
    end
end

function table.call(t, method, ...)
    local v, f
    for i=1,#t do
        v = t[i]
        f = v[method]
        if f then
            f(v, ...)
        end
    end
end

function table.update(t, dt)
    table.call(t, 'update', dt)
end

function table.draw(t)
    table.call(t, 'draw')
end

table.foreach = nil
table.foreachi = nil

function table:getnKeys()
    local n = 0
    for _,_ in pairs(self) do
        n = n + 1
    end
    return n
end

function table:forEachKey(f)
    for k,v in pairs(self) do
        f(v, k, self)
    end
    return self
end

function table:getn()
    return #self
end

function table:forEach(f)
    for i=1,#self do
        f(self[i], i, self)
    end
    return self
end

function table:enumerate()
    local i = 0
    local n = #self
    return function ()
        i = i + 1
        if i <= n then
            return i, self[i]
        end
        return nil
    end
end

function table:enumerateBy2()
    local i = 0
    local n = #self
    return function ()
        i = i + 1
        if i < n then
            return i, self[i], self[i+1]
        end
        return nil
    end
end

function table:enumerateBy3()
    local i = 0
    local n = #self
    return function ()
        i = i + 1
        if i < n-1 then
            return i, self[i], self[i+1], self[i+2]
        end
        return nil
    end
end

function table:map(f, ...)
    local map = Table()
    for i=1,#self do
        map[i] = f(self, i, self[i], ...)
    end
    return map
end

function table:copy(deepCopy)
    deepCopy = deepCopy or true

    local c = {}
    for k,v in pairs(self) do
        if type(v) == 'table' and deepCopy then
            c[k] = table.copy(v)
        else
            c[k] = v
        end
    end
    for i,v in ipairs(self) do
        if type(v) == 'table' and deepCopy then
            c[i] = table.copy(v)
        else
            c[i] = v
        end
    end

    local metatable = getmetatable(self)
    if metatable then
        setmetatable(c, metatable)
    end

    return c
end

function table:copyFast()
    local copy = {}

    for k,v in pairs(self) do
        copy[k] = v
    end

    for i=1,#self do
        copy[i] = self[i]
    end

    return copy
end

function table.load(name)
    if fs.getInfo(name) == nil then return end

    local content = fs.read(name)
    local ftables = loadstring(content)

    return ftables and ftables() or nil
end

function table.save(t, name)
    assert(name)

    local code = "return "..table.format(t, name)
    local file = fs.write(name, code)
end

function table.range(min, max, step)
    step = step or 1

    local t = Table()
    for i=1,max-min,step do
        t[i] = min+i-1
    end
    return t
end

local conversions

function table.tostring(t)
    if t == nil then return 'nil' end

    local code = ""
    for k,v in pairs(t) do
        local typeIndex = type(k)
        if typeIndex == 'string' then
            code = code..k.." = "..tostring(v)..","..NL
        end
    end
    return code
end

table.random = function (self)
    return self[randomInt(1, #self)]
end

table.chainIt = function (self)
    local n = #self
    self[1].previous = self[n]
    self[n].next = self[1]

    for i=1,n-1 do
        self[i].next = self[i+1]
        self[i+1].previous = self[i]
    end
end

-- TODO a refactorer et tester
--function Table:minvar(var)
--    local v = 99999999

--    for i=1,#self do
--        v = min(v, self[i][var])
--    end

--    return v
--end

--function Table:maxvar(var)
--    local v = -99999999

--    for i=1,#self do
--        v = max(v, self[i][var])
--    end

--    return v
--end

--function Table:avg(var)
--    local v = 0
--    local n = 0

--    for i=1,#self do
--        v = v + self[i][var]
--        n = n + 1
--    end

--    return v / n
--end

--function Table:scan(attr, f, classType, className)
--    self.already_scan = true
--    do
--        local t
--        if attr then 
--            t = self[attr] or self
--        else
--            t = self
--        end

--        table.forEach(t,
--            function (v, k, t)
--                local isClassType = (classType == nil or typeOf(v) == classType)
--                local isClassName = (className == nil or left(k, #className) == className)

--                if isClassType and isClassName then
--                    f(v, k, t)
--                end

--                if type(v) == 'table' and v.already_scan == nil then
--                    Table.scan(v, attr, f, classType, className)
--                end
--            end)
--    end
--    self.already_scan = nil
--end

function table.format(t, name, tab_)
    local tab = (tab_ or "").."    "

    local code = "{"
    local varName

    for k,v in pairs(t) do
        if v ~= t then
            local typeIndex = type(k)
            if typeIndex == 'number' then
                varName = '['..k..']'
            else
                varName = '["'..k..'"]'
            end

            code = code..NL..tab..varName.." = "..convert(v, k, tab)..","
        end
    end

    code = code..NL..(tab_ or "").."}"
    return code
end

conversions = {
    ['table'] = function (v)
        if v.__formatting then return "..." end

        v.__formatting = true
        local result
        if v.format then
            result = v:format()
        else
            result = table.format(v)
        end
        v.__formatting = nil

        return result
    end,

    ['string'] = function (v)
        return '"'..tostring(v)..'"'
    end,

    ['number'] = function (v)
        return tostring(v)
    end,

    ['boolean'] = function (v)
        return v and 'true' or 'false'
    end,
}

function convert(v)
    local conversion = conversions[type(v)] or tostring
    return conversion(v)
end

function table.test()
    local array = {}

    ut.assert('exist', Table)
    ut.assert('new', Table())
    ut.assert('new(array)', Table(array) == array)

    local t1 = Table()
    ut.assert('add(item)', t1:add('item') == t1)
    ut.assert('getn', t1:getn() == 1)

    local t = {}
    table.insert(t, 1)
    table.remove(t, 1)

    assert(#t == 0)
end
