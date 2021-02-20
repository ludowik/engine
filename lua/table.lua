local __min, __max = math.min, math.max

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

function table:add(item)
    table.insert(self, item)
    return self
end

function table:addItems(items)
    for _,item in ipairs(items) do
        table.insert(self, item)
    end
    return self
end

function table:addKeys(items)
    for k,item in pairs(items) do
        self[k] = item
    end
    return self
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

function table:iterator()
    return ipairs(self)
end

function table:by2()
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

function table:by3()
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

function table:attribs(vars)
    for var,value in pairs(vars) do
        self[var] = value
    end
    return self
end

function table:clone()
    return table.copy(self, true)
end

function table:derived(mt, override)
    for k,f in pairs(mt) do
        if k ~= 'setup' then
            if type(f) == 'function' and (override or self[k] == nil) then
                self[k] = f
            end
        end
    end
end

local excludeFunctions = {
    'setup',
    'init'
}

function table:push2Global()
    local override = false

    local t = _G
    for k,f in pairs(self) do
        if not k:inList(excludeFunctions) then
            if type(f) == 'function' and (override or t[k] == nil) then
                t[k] = f
            end
        end
    end
end

function table:log()
    if self == nil then return end

    print(self)
    for k,v in pairs(self) do
        print(tostring(k)..' = '..tostring(v))
    end
end

function table:indexOf(item)
    for i=1,#self do
        if self[i] == item then
            return i
        end
    end
end

function table:first(item)
    if item then
        self.currentItem = self[table.indexOf(self, item) or 1]
    else
        self.currentItem = self[1]
    end
    return self.currentItem
end

function table:last()
    self.currentItem = self[#self]
    return self.currentItem
end

function table:current()
    return self.currentItem or self[1]
end

function table:navigate(currentItem, nextIndex, defaultIndex)
    currentItem = currentItem or self.currentItem
    nextIndex = nextIndex or 1
    defaultIndex = defaultIndex or 1

    local nextItem
    if currentItem == nil then
        nextItem = self[defaultIndex]
    else
        if type(currentItem) == 'table' and currentItem.nodes and #currentItem.nodes > 0 then
            nextItem = currentItem.nodes[1]
        else
            self = type(currentItem) == 'table' and currentItem.parent and currentItem.parent.nodes or self
            for i,v in ipairs(self) do
                if v == currentItem then
                    nextItem = self[(i+nextIndex-1)%#self+1] or self[defaultIndex]
                    break
                end
            end
        end
    end

    self.currentItem = nextItem
    return self.currentItem
end

function table:next(currentItem)
    return table.navigate(self, currentItem, 1, 1)
end

function table:previous(currentItem)
    return table.navigate(self, currentItem, -1, #self)
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

function table:call(method, ...)
    local object, f
    for i=1,#self do
        object = self[i]
        f = object[method]
        if f then
            f(object, ...)
        end
    end
end

function table:callWithLog(method, ...)
    local object, f
    for i=1,#self do
        object = self[i]
        f = object[method]
        if f then
            print(method..' '..classnameof(object))
            io.flush()
            f(object, ...)
        end
    end
end

function table:update(dt)
    table.call(self, 'update', dt)
end

function table:draw()
    table.call(self, 'draw')
end

table.foreach = nil
table.foreachi = nil

function table:getnKeys()
    local n = 0
    for k,v in pairs(self) do
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

function table:iterator()
    return ipairs(self)
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
    if getInfo(name) == nil then return end

    local content = load(name)
    if content then
        local ftables = loadstring(content)
        return ftables and ftables() or nil
    end
end

function table:save(name)
    assert(name)

    local code = 'return '..table.format(self, name)
    local file = save(name, code)
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

function table:tostring()
    if self == nil then return 'nil' end

    local code = ''
    for _,iter in pairs({pairs, ipairs}) do
        for k,v in iter(self) do
            code = code..tostring(k)..' = '..tostring(v)..','..NL
        end
    end
    return code
end

function table:random()
    return self[randomInt(1, #self)]
end

function table:chainIt()
    local n = #self
    self[1].previous = self[n]
    self[n].next = self[1]

    for i=1,n-1 do
        self[i].next = self[i+1]
        self[i+1].previous = self[i]
    end
end

function table:min(var)
    local v = math.maxinteger

    if var then
        for i=1,#self do
            v = __min(v, self[i][var])
        end
    else
        for i=1,#self do
            v = __min(v, self[i])
        end
    end

    return v
end

function table:max(var)
    local v = math.mininteger

    if var then
        for i=1,#self do
            v = __max(v, self[i][var])
        end
    else
        for i=1,#self do
            v = __max(v, self[i])
        end
    end

    return v
end

function table:avg(var)
    local v = 0
    local n = 0

    if var then
        for i=1,#self do
            v = v + self[i][var]
            n = n + 1
        end
    else
        for i=1,#self do
            v = v + self[i]
            n = n + 1
        end
    end

    return v / n
end

local scanning = {}

function table:scan(attr, f, classType, className)
    local t
    if attr then
        t = self[attr] or self
    else
        t = self
    end

    if not scanning[t] then
        scanning[t] = true

        table.forEachKey(t,
            function (v, k, t)
                local isClassType = (classType == nil or typeof(v) == classType)
                local isClassName = (className == nil or left(k, #className) == className)

                if isClassType and isClassName then
                    f(v, k, t)
                end

                if type(v) == 'table' and not scanning[v] then
                    table.scan(v, attr, f, classType, className)
                end
            end)
    end
    scanning[t] = nil
end

function table:format(name, tab_)
    local tab = (tab_ or "").."    "

    local code = "{"
    local varName

    for k,v in pairs(self) do
        if v ~= self then
            local typeIndex = type(k)
            if typeIndex == 'number' then
                varName = '['..k..']'
            else
                varName = '["'..k..'"]'
            end

            code = code..NL..tab..varName.." = "..table.convert(v, k, tab)..","
        end
    end

    code = code..NL..(tab_ or "").."}"
    return code
end

conversions = {
    ['nil'] = function (v)
        return 'nil'
    end,

    ['table'] = function (v)
        if v.__formatting then return "..." end

        v.__formatting = true
        local result
        if type(v.format) == 'function' then
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

function table.convert(v)
    local conversion = conversions[type(v)] or tostring
    return conversion(v)
end

class('__table')

function __table.test()
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

    local t1 = Table{1,2,3,4,0,5,6,7,8,9}
    local t2 = Table{{a=3},{a=7},{a=2}}

    ut.assertEqual('min 1', t1:min(), 0)
    ut.assertEqual('min 2', t2:min('a'), 2)

    ut.assertEqual('max 1', t1:max(), 9)
    ut.assertEqual('max 2', t2:max('a'), 7)

    ut.assertEqual('avg 1', t1:avg(), 4.5)
    ut.assertEqual('avg 2', t2:avg('a'), 4)

    table.scan(_G, nil, function () end)
end
