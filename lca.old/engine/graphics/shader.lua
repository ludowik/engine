class('Shader')

function Shader.setup()
    shaders = {}

    shaders['standard'] = Shader()
    shaders['terrain'] = Shader('terrain', 'terrain', 'standard')
    shaders['test'] = Shader('test', 'test', 'test')
end

function Shader:init(name, vertFile, fragFile)
    name = name or 'standard'
    vertFile = vertFile or name
    fragFile = fragFile or name    

    local versionCode = "#pragma language glsl3"..NL

    local vertexCode = fs.read('engine/shaders/'..vertFile..'.vertex')
    local pixelCode  = fs.read('engine/shaders/'..fragFile..'.fragment')

    vertexCode = vertexCode:gsub('#include "(%w+%.-%w-)"', function (fileName)
            return fs.read('engine/shaders/'..fileName)
        end
    )

    pixelCode = pixelCode:gsub('#include "(%w+%.-%w-)"', function (fileName)
            return fs.read('engine/shaders/'..fileName)
        end
    )

    self.shader = graphics.newShader(
        versionCode..pixelCode,
        versionCode..vertexCode)
end

function Shader:pushTableToShader(table, name, option)
    local t = {}
    t[option] = #table

    self:pushToShader(t)
    for i,item in ipairs(table) do
        self:pushToShader(item, name, i-1)
    end
end

function Shader:pushToShader(object, array, i)
    for k,v in pairs(object) do
        if array then
            if i then
                k = array.."["..i.."]".."."..k
            else
                k = array.."."..k
            end
        end

        local typ = typeOf(v)
        if typ == 'vector' then
            self.shader:send(k, {v.x, v.y, v.z})

        elseif typ == 'color' then
            local r,g,b,a = v:rgba()
            self.shader:send(k, {r,g,b,a})

        elseif typ == 'boolean' then
            self.shader:send(k, v and 1 or 0)

        else
            self.shader:send(k, v)
        end
    end
end

local uniforms = {}
function Shader:setUniforms(mesh, useTexture)
    graphics.setShader(self.shader)

    uniforms.pvmMatrix = pvmMatrix()
    uniforms.modelMatrix = modelMatrix()

    if useTexture or mesh and mesh.texture and mesh.texture ~= mesh.defaultTexture then
        uniforms.useTexture = true
    else
        uniforms.useTexture = false
    end

    if light() and #lights > 0 then
        uniforms.useLight = true

        self:pushToShader(currentMaterial, 'material')
        self:pushTableToShader(lights, 'lights', 'useLight')
    else
        uniforms.useLight = false
    end

--    if mesh and mesh.drawBorder then
--        uniforms.drawBorder = mesh.drawBorder
--    else
--        uniforms.drawBorder = 0
--    end

    self:pushToShader(uniforms)
end
