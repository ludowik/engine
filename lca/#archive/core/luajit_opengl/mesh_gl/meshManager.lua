class('MeshManager')

function MeshManager:init()
    self.meshes = Table()
    self.depth = 0
    self.depthIncrement = 0.1

    config.deferredDraw = false
end

function MeshManager:nextDepth()
    self.depth = self.depth + self.depthIncrement
    return self.depth
end

function MeshManager:update(dt)
    self.depth = 0
end

function MeshManager:addMesh(m, primitiveMode, polygonMode)
    if config.deferredDraw then
        if self.meshes[m] == nil then
            self.meshes[m] = m
            m.instances = Table()
        end

        self:addInstance(m, primitiveMode, polygonMode)
    else
        m:render(primitiveMode, polygonMode)
    end
end

function MeshManager:addInstance(m, primitiveMode, polygonMode)
    assert()
    
    m.instances:add({
            modelMatrix = modelMatrix(),
            uniformColor = m.uniformColor,
            useUniformColor = m.useUniformColor,
            texture = m.texture,
            primitiveMode = primitiveMode,
            polygonMode = polygonMode,
            lightMode = light(),
            blendMode = blendMode(),
            width = strokeWidth()
        })
end

function MeshManager:flush()
    self:drawMeshes()
    self:init()
end

function MeshManager:drawMeshes()
    for k,m in pairs(self.meshes) do
        self:drawMeshInstances(m)
    end
end

function MeshManager:drawMeshInstances(m)
    if m.mesh2d and gl then
        initMode('none', false)
    end

    if m.instances then
        local drawInstanced = true

        local ref = m.instances[1]
        for i=2,#m.instances do
            local instance = m.instances[i]
            if instance.texture ~= ref.texture or instance.blendMode ~= ref.blendMode then
                drawInstanced = false
            end
        end

        if drawInstanced then
            blendMode(ref.blendMode)
            light(ref.lightMode)

            m:render(m.instances[1].primitiveMode, m.instances[1].polygonMode)
        else
            for i=1,#m.instances do
                local instance = m.instances[i]
                m.instances.i = i
                m.instances.n = 1

                blendMode(instance.blendMode)

                m:render(instance.primitiveMode, instance.polygonMode)
            end
        end

        m.instances = nil
    else
        m:render()
    end

    if m.mesh2d and gl then
        initMode()
    end
end
