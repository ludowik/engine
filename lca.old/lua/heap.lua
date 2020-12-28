local heaps = {}

function push(heapName, value)
    assert(value)
    heaps[heapName] = heaps[heapName] or {}
    table.insert(heaps[heapName], value)
    return value
end

function pop(heapName)
    return table.remove(heaps[heapName])
end
