class 'ResourceManager'

function ResourceManager:init()
    self.resources = Table()
    self.frame = 0
end

function ResourceManager:get(resType, name, klass)
    local ref = resType..'.'..name

    if not self.resources[ref] then
        local resource = klass(name)
        self.resources[ref] = {
            resource = resource,
            count = 1,
            frame = self.frame
        }
    else
        self.resources[ref].count = self.resources[ref].count + 1
        self.resources[ref].frame = self.frame
    end

    return self.resources[ref].resource
end

function ResourceManager:update(dt)
    for k,v in pairs(self.resources) do
        if v.frame < self.frame - 60 then
            v.resource:release()
            self.resources[k] = nil
        end
    end

    self.frame = self.frame + 1
end

function ResourceManager:release()
    for k,v in pairs(self.resources) do
        v.resource:release()
        self.resources[k] = nil
    end
end
