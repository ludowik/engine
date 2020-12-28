lib('io')

function table:clear(value)
    local n = #self
    for i=n,1,-1 do
        self[i] = value -- default is nil
    end
    return self
end

function table:add(...)
    local addItems = self.addItems or table.addItems
    addItems(self, {...})
    return self
end

function table:addItems(items)
    local addItem = self.addItem or table.addItem
    for _,item in ipairs(items) do
        addItem(self, item)
    end
    return self
end

function table:addItem(item)
    table.insert(self, item)
end

function table:addKeys(items)
    for k,item in pairs(items) do
        self[k] = item
    end
    return self
end

function table:push(item)
    return table.insert(self, item)
end

function table:pop()
    return table.remove(self)
end

function table:queue(item)
    return table.insert(self, 1, item)
end

function table:dequeue()
    return table.remove(self, 1)
end

function table:first()
    return self[1]
end

function table:last()
    return self[#self]
end

function table:getn()
    return #self
end

function table:getnKeys()
    local n = 0
    for _,_ in pairs(self) do
        n = n + 1
    end
    return n
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

function table:__add(t)
    local g = Table()
    g:addItems(self)
    g:addItems(t)
    return g
end

table.foreach = nil
table.foreachi = nil

function table:forEachKey(f)
    for k,v in pairs(self) do
        f(v, k, self)
    end
    return self
end

function table:forEach(f)
    for i,v in ipairs(self) do
        f(v, i, self)
    end
    return self
end

function table:nextValue()
    local t = self
    local i = t.i or 0
    i = i + 1
    if i > #t then
        i = 1
    end
    t.i = i
    return t[i]
end

function table:nextItem(item)
    local i = self:findItem(item) or 0
    i = i >= #self and 1 or (i+1)
    return self:get(i)
end

function table:previousItem(item)
    local i = self:findItem(item) or 0
    i = i <= 1 and #self or (i-1)
    return self:get(i)
end

function table:update(...)
    local n = #self
    for i=1,n do
        local item = self[i]
        if item and type(item) == 'table' and item.update then
            item:update(...)
        end
    end
    return self
end

function table:layout(...)
    local n = #self
    for i=1,n do
        local item = self[i]
        if item and type(item) == 'table' and item.layout then
            item:layout(...)
        end
    end
    return self
end

function table:draw(f, ...)
    local n = #self
    for i=1,n do
        local item = self[i]
        if item and type(item) == 'table' and item.draw then
            item:draw(f, ...)
        elseif f and type(f) == 'function' then
            f(item)
        end
    end
    return self
end

function table:print()
    for i,v in ipairs(self) do
        print(i, v)
    end
    
    for k,v in pairs(self) do
        print(k, v)
    end
    
    io.stdout:flush()
    
    return self
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

table.clone = table.copy

function table:copyFast()
    local copy = {}

    for k,v in pairs(self) do
        copy[k] = v
    end

    local v

    local n = #self
    for i=1,n do
        v = self[i]
        copy[i] = v
    end

    return copy
end

table.unpack = unpack

function table:derived(d, overload)
    local mt = self
    local md = d

    table.forEach(md, function (k, v)
            if type(v) == 'function' then
                if mt[k] == nil or overload then
                    mt[k] = v
                end
            end
        end)

    return self
end

class('Table', table)

function Table:init(t, val)
    if type(t) == 'table' then
        return t

    elseif type(t) == 'number' then
        for i=1,t do
            self[i] = val
        end

    elseif t then
        assert()
    end
end

function Table:sort(...)
    table.sort(self, ...)
    return self
end

function Table:map(f, ...)
    local map = Table()
    for i,v in ipairs(self) do
        map[i] = f(self, i, v, ...)
    end
    return map
end

function Table:get(i)
    return self[i]
end

function Table:set(i, item)
    self[i] = item
    return self, item
end

function Table:minvar(var)
    local v = 99999999

    for i=1,#self do
        v = min(v, self[i][var])
    end

    return v
end

function Table:maxvar(var)
    local v = -99999999

    for i=1,#self do
        v = max(v, self[i][var])
    end

    return v
end

function Table:avg(var)
    local v = 0
    local n = 0

    for i=1,#self do
        v = v + self[i][var]
        n = n + 1
    end

    return v / n
end

function Table:scan(attr, f, classType, className)
    self.already_scan = true
    do
        local t
        if attr then 
            t = self[attr] or self
        else
            t = self
        end

        table.forEach(t,
            function (v, k, t)
                local isClassType = (classType == nil or typeOf(v) == classType)
                local isClassName = (className == nil or left(k, #className) == className)

                if isClassType and isClassName then
                    f(v, k, t)
                end

                if type(v) == 'table' and v.already_scan == nil then
                    Table.scan(v, attr, f, classType, className)
                end
            end)
    end
    self.already_scan = nil
end
