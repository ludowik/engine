-- resource

resources = class('Resources')
resources.arrays = Table()

resources.nFrame = 1

function resources.get(type, name, create, release, autoRelease, ...)
    local ref = type..'.'..tostring(name)

    local temp = resources.arrays[ref]    
    if temp == nil then
        local newRes = create(name, ...)
        if newRes then
            temp = {
                res = newRes,
                release = release or resources.release,
                autoRelease = autoRelease ~= false and true or false,
                nFrame = resources.nFrame,
                ref = 1
            }
            resources.arrays[ref] = temp            
        end
    end

    if temp then
        if temp.nFrame < resources.nFrame then
            temp.nFrame = resources.nFrame 
            temp.ref = temp.ref + 1
        end
        return temp.res
    end
end

function resources.release(ref)
    ref = nil
end

function resources.gc(releaseAll)
    for k,ref in pairs(resources.arrays) do
        ref.ref = ref.ref - 1
        
        -- TODO : utiliser plutot une constante ou une durée
        if ref.autoRelease and ref.ref < -config.framerate or releaseAll then
            ref.release(ref.res)
            resources.arrays[k] = nil
        end
    end

    resources.nFrame = resources.nFrame + 1
end
