class 'Array'

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
