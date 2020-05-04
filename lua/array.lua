class 'Array'

function Array:add(value)
    table.insert(self, value)
end

function Array:remove(i)
    table.remove(self, i)
end

function Array:items()
    return ipairs(self)
end
