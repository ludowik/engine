do
    local memoryCurrent = tointeger(collectgarbage('count'))
    
    local memoryMin = memoryCurrent
    local memoryMax = memoryCurrent
    
    function memory()
        memoryCurrent = tointeger(collectgarbage('count'))
        
        memoryMin = min(memoryCurrent, memoryMin)
        memoryMax = max(memoryCurrent, memoryMax)
        
        return memoryCurrent, memoryMin, memoryMax
    end
end

function formatMemory()
    local size = collectgarbage('count') / 1024
    return string.format('%.2f', size)
end

function gc()
    collectgarbage('collect')
end
