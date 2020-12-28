Shader = class('love.Shader')

function Shader.setup()
    Shader.vector = {0, 0, 0}
    Shader.color = {0, 0, 0, 0}

    Shader.shadersPath = 'core/love/shaders'

    Shader.shaders = {}

    Shader.shaders['default'] = Shader('standard', 'standard', 'standard')

    Shader.shaders['line'] = Shader('line', 'line', 'rect')
    Shader.shaders['rect'] = Shader('rect', 'rect', 'rect')
    Shader.shaders['circle'] = Shader('circle', 'rect', 'circle')

    Shader.shaders['mesh'] = Shader('mesh', 'standard', 'standard')

    Shader.shaders['terrain'] = Shader('terrain', 'terrain', 'standard')
end

function Shader:init(name, vertFile, fragFile)
    assert(name)

    self:reset()

    self.name = name

    vertFile = vertFile or name
    fragFile = fragFile or name    

    -- TODO utiliser loadFiles
    local vertexCode = fs.read(Shader.shadersPath..'/'..vertFile..'.vertex')
    local fragmentCode  = fs.read(Shader.shadersPath..'/'..fragFile..'.fragment')

    self.vertexCode = vertexCode:gsub('#include "(%w+%.-%w-)"', function (fileName)
            return fs.read(Shader.shadersPath..'/'..fileName)
        end)

    self.fragmentCode = fragmentCode:gsub('#include "(%w+%.-%w-)"', function (fileName)
            return fs.read(Shader.shadersPath..'/'..fileName)
        end)

    self:compile()
end

function Shader:reset()
    self.uniforms = {
    }
end

function Shader:compile()
    print('compile shader : '..self.name..' ('..(self.startLine or 0)..')')

    local status, res = pcall(function ()
            return love.graphics.newShader(
                self.fragmentCode,
                self.vertexCode)
        end)

    if status then
        self.shader = res
    else
        self.error = res
    end
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

        if self.shader:hasUniform(k) then
            local typ = typeof(v)
            if typ == 'vec2' then
                Shader.vector[1], Shader.vector[2] = v.x, v.y
                self.shader:send(k, Shader.vector)

            elseif typ == 'vec3' then
                Shader.vector[1], Shader.vector[2], Shader.vector[3] = v.x, v.y, v.z
                self.shader:send(k, Shader.vector)

            elseif typ == 'color' then
                Shader.color[1], Shader.color[2], Shader.color[3], Shader.color[4] = v.r, v.g, v.b, v.a
                self.shader:send(k, Shader.color)

            elseif typ == 'boolean' then
                self.shader:send(k, v and 1 or 0)

            elseif typ == 'cdata' and v.data then
                local data = {}
                for i=1,16 do
                    data[i] = v[i]
                end
                self.shader:send(k, data)

            else
                self.shader:send(k, v)
            end
        end
    end
end

function Shader:use(mesh)    
    love.graphics.setShader(self.shader)
end

function Shader:unuse()    
    love.graphics.setShader()
end

function Shader:send(uniform, data)
    if self.shader:hasUniform(uniform) == false or data == nil then
        warning(false, self.name..':'..uniform.." : unknown uniform '"..data.."'")
        return
    end

    local dataType = typeof(data);
    if dataType == 'vec3' then
        self.shader:send(uniform,
            {
                data.x,
                data.y,
                data.z
            })
    elseif dataType == 'vec2' then
        self.shader:send(uniform,
            {
                data.x,
                data.y,
                0
            })
    else
        self.shader:send(uniform, data)
    end
end

function Shader:hasUniform(...)
    self.shader:hasUniform(...)
end

class('ShaderToy', Shader)

function ShaderToy:init(name, path, header, code, ender)
    self:reset()

    self.name = name

    self.uniforms.iTime = 0
    self.uniforms.iMouse = vec4()

    self.fragmentCode = header..'\n'..code..'\n'..ender

    local lines = header:split(NL)
    self.startLine = #lines + 1

    Shader.shadersPath = 'core/luajit_opengl/shaders'

    self:compile()
end
