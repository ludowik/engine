require 'engine.mesh.mesh'

Class('MeshText', Mesh)

function MeshText:MeshText(txt)
    Mesh.init(self)
    
    self:create()

    self.txt = txt
    self.texture = image()
    self.shader = shaders['text']
end

function MeshText:create()    
    Model.set(self, Model.text())
end

local manageRes = true

function MeshText.textSize(txt)
    local ttf = getFont()
    ttf.txt = txt

    if manageRes then
        MeshText.texture = resources.get('texture',
            ttf,
            MeshText.initRender,
            MeshText.releaseRender)
    else
        MeshText.texture = MeshText.initRender(ttf, true)
    end

    local w, h = 0, 0
    if MeshText.texture then
        w, h = MeshText.texture.width, MeshText.texture.height
    end

    if not manageRes then
        MeshText.releaseRender(MeshText.texture)
        MeshText.texture = nil
    end

    return w, h
end

function MeshText:drawMesh2d()
    if #self.txt == 0 then return end

    self:setColors(fill())

    local ttf = getFont()
    ttf.txt = self.txt

    if manageRes then
        self.texture = resources.get('texture',
            ttf,
            MeshText.initRender,
            MeshText.releaseRender)
    else
        self.texture = MeshText.initRender(ttf)
    end

    blendMode(NORMAL)
    
    self:addMesh2d(self.x, self.y, 0, self.texture.width, self.texture.height, 0)
    
    if not manageRes then
        MeshText.releaseRender(self.texture)
        self.texture = nil
    end
end

function MeshText.initRender(ref, computeSizeOnly)
    return ref.createImage(ref, computeSizeOnly)    
end

function MeshText.releaseRender(res)
    res:freeTexture()
end
