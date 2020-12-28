-- resource

resources = class('Resources')

function resources.setup()
    resources.arrays = Table()

    resources.nFrame = 1
    resources.nRes = 0
end

function resources.get(resType, name, create, release, autoRelease, frameBeforeErase)
    assert(autoRelease ~= nil)

    local ref = resType..'.'..tostring(name)

    local resInstance = resources.arrays[ref]    
    if resInstance == nil then
        local newRes = create(name)
        if newRes then
            resInstance = {
                resType = resType,
                res = newRes,
                release = release or resources.release,
                autoRelease = autoRelease ~= false and true or false,
                frameBeforeErase = frameBeforeErase or -10,
                nFrame = resources.nFrame,
                nRef = 1
            }
            resources.arrays[ref] = resInstance  

            resources.nRes = resources.nRes + 1
        end
    end

    if resInstance then
        if resInstance.nFrame < resources.nFrame then
            resInstance.nFrame = resources.nFrame 
            resInstance.nRef = resInstance.nRef + 1
        end
        return resInstance.res
    end
end

function resources.gc(resType)
    for ref,resInstance in pairs(resources.arrays) do
        resInstance.nRef = resInstance.nRef - 1

        if resInstance.autoRelease and resInstance.nRef <= resInstance.frameBeforeErase
        or resType == 'all'
        or resInstance.resType == resType
        then
            resInstance.release(resInstance.res)
            resources.arrays[ref] = nil

            resources.nRes = resources.nRes - 1
        end
    end

    resources.nFrame = resources.nFrame + 1
end

function resources:update(dt)
    resources.gc()
end
