class 'Array' : extends(table)

function Array:init(t)
    if t then
        setmetatable(t, Array)
        return t
    end
end

function Array:add(value)
    table.insert(self, value)
end

function Array:remove(i)
    table.remove(self, i)
end

function Array:items(reverse)
    if not reverse then
        local i = 0
        return function ()
            i = i + 1
            if i <= #self then
                return i,self[i]
            end
        end
    else
        local i = #self + 1
        return function ()
            i = i - 1
            if i >= 1 then
                return i,self[i]
            end
        end
    end
end

function Array:apply(f)
    for i,v in pairs(self) do
        self[i] = f(v)
    end
end

function Array:resize(n)
end

function Array.test()
    local t = Array()
    ut.assertEqual('table', #t, 0)

    for i=1,100 do
        t:add(i)
    end
    ut.assertEqual('table.add', #t, 100)

    for i,v in t:items() do
        ut.assertEqual('table.items', v, i)
        ut.assertEqual('table.items', v, t[i])
    end

    for i,v in t:items(true) do
        ut.assertEqual('table.items', v, i)
        ut.assertEqual('table.items', v, t[i])
    end

    for i=1,100 do
        t:remove(1)
    end
    ut.assertEqual('table.remove', #t, 0)
end
