Shader = class('luajit.shader')
Shader.ids = {}

-- TODO : localiser les emplacements par shader
LOCATION_VERTICES = 0
LOCATION_NORMALS = 1
LOCATION_COLORS = 2
LOCATION_TEX_COORDS = 3
LOCATION_INSTANCE_MODEL_MATRIX = 4 -- 5 & 6 & 7
LOCATION_INSTANCE_COLORS = 8
LOCATION_INSTANCE_WIDTH = 9

function Shader.setup()
end

function Shader:init(name, vertFile, fragFile, geoFile)
    self:reset()

    self.vertFile = vertFile or {'include.vertex', name..'.vertex'}
    self.fragFile = fragFile or {'include.fragment', name..'.fragment'}

    self.geoFile = geoFile

    self.name = name

    for _,refs in ipairs{self.vertFile, self.fragFile, self.geoFile} do
        for i,ref in ipairs(refs) do
            if lfs.attributes(ref) then
            elseif lfs.attributes(Shader.shadersPath..'/'..ref) then
                ref = Shader.shadersPath..'/'..ref
            end

            refs[i] = ref
        end
    end

    self:update()
end

function Shader:update()
    self.vert, self.vertLines = self:loadCode(self.vertFile, 'vert')
    self.frag, self.fragLines = self:loadCode(self.fragFile, 'frag')

    if self.geoFile then
        self.geo, self.geoLines  = self:loadCode(self.geoFile, 'geo')
    else
        self.vert = (self.vert
            :replace("vPositionG", "vPosition")
            :replace("vColorG", "vColor"))
    end

    self:compile()
end

function Shader:reset()
    self.ids = {
        program = 0,
    }

    self.uniforms = {}

    self.time = {
        vert = 0,
        frag = 0,
        geo = 0,
    }
end

function Shader:loadCode(file, ext)
    local currentTime = checkFiles(file, nil, self.time[ext])
    if gl.glIsProgram(self.ids.program) == gl.GL_FALSE or currentTime > self.time[ext] then
        self.time[ext] = currentTime
        self.needCompilation = true
    end

    return loadFiles(file, nil)
end

function Shader:compile()
    if not self.needCompilation then return end
    self.needCompilation = nil

    assert(self.vert and self.frag)

    print('compile shader : '..self.name)

    if gl.glIsProgram(self.ids.program) == gl.GL_TRUE then
        self:release()
    end

    self.ids.program = gl.glCreateProgram()
    assert(self.ids.program ~= nil)

    if self.vert then
        self.ids.vert = self:buildShader(self.ids.vert, gl.GL_VERTEX_SHADER, self.vert, self.vertFile, self.vertLines, self.name, 'vertex')
        self:attachShader(self.ids.vert)
    end

    if self.frag then
        self.ids.frag = self:buildShader(self.ids.frag, gl.GL_FRAGMENT_SHADER, self.frag, self.fragFile, self.fragLines, self.name, 'fragment')
        self:attachShader(self.ids.frag)
    end

    if self.geo then
        self.ids.geo = self:buildShader(self.ids.geo, gl.GL_GEOMETRY_SHADER, self.geo, self.geoFiles,self.geoLines, self.name, 'geo')
        self:attachShader(self.ids.geo)
    end

    gl.glLinkProgram(self.ids.program)

    local error = gl.glGetProgramiv(self.ids.program, gl.GL_LINK_STATUS)
    assert(error == gl.GL_TRUE, gl.glGetProgramInfoLog(self.ids.program))

    self.attribLocations = {
        vertices     = gl.glGetAttribLocation(self.ids.program, 'VertexPosition'),
        colors       = gl.glGetAttribLocation(self.ids.program, 'VertexColor'),
        normals      = gl.glGetAttribLocation(self.ids.program, 'VertexNormal'),
        translations = gl.glGetAttribLocation(self.ids.program, 'VertexTranslation'),
        texCoords    = gl.glGetAttribLocation(self.ids.program, 'VertexTexCoord'),
    }

    self.uniformLocations = {
        pvMatrix    = gl.glGetUniformLocation(self.ids.program, 'pvMatrix'),
        modelMatrix = gl.glGetUniformLocation(self.ids.program, 'modelMatrix'),
    }

    self.uniformTypes = {
    }

    self.uniformGlslTypes = {
    }

    local activeUniforms = gl.glGetProgramiv(self.ids.program, gl.GL_ACTIVE_UNIFORMS)  
    for i=0,activeUniforms-1 do
        local glslType, name = gl.glGetActiveUniform(self.ids.program, i)
        self.uniformGlslTypes[name] = glslType
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
        self:send(k, v)
    end
end

function Shader:send(k, v)
    local uid = self.uniformLocations[k]
    if uid == nil then
        self.uniformLocations[k] = gl.glGetUniformLocation(self.ids.program, k)
        uid = self.uniformLocations[k]
        if uid ~= -1 then
            warning(false, self.name.." : unknown uniform '"..k.."'")
        end
    end

    if uid ~= -1 then
        local utype = self.uniformTypes[k]
        if utype == nil then
            self.uniformTypes[k] = typeof(v)
            utype = self.uniformTypes[k]
        end

        if utype == 'number' then
            if self.uniformGlslTypes[k] == gl.GL_INT then
                gl.glUniform1i(uid, v)
            elseif self.uniformGlslTypes[k] == gl.GL_SAMPLER_2D then
                gl.glUniform1i(uid, v)
            else
                gl.glUniform1fv(uid, 1, v)
            end

        elseif utype == 'vec2' then
            gl.glUniform2fv(uid, 1, v.x, v.y)

        elseif utype == 'vec3' then
            gl.glUniform3fv(uid, 1, v.x, v.y, v.z)

        elseif utype == 'vec4' then
            gl.glUniform4fv(uid, 1, v.x, v.y, v.z, v.w)

        elseif utype == 'color' then
            gl.glUniform4fv(uid, 1, v.r, v.g, v.b, v.a)

        elseif utype == 'matrix' or utype == 'cdata' then
            if matrix == glm_matrix then
                assert()
                gl.glUniformMatrix4fv(uid, 1, gl.GL_FALSE, v)
            else
                gl.glUniformMatrix4fv(uid, 1, gl.GL_TRUE, v)
            end

        elseif utype == 'boolean' then
            if v == true then
                gl.glUniform1i(uid, 1)
            else
                gl.glUniform1i(uid, 0)
            end

        else
            assert(false, "shader : unmanaged type "..utype.." for "..k)
        end
    end
end

function glUniformVec2(uid, v)
    gl.glUniform2fv(uid, 1, v.x, v.y)
end

function glUniformVec3(uid, v)
    gl.glUniform3fv(uid, 1, v.x, v.y, v.z)
end

function glUniformVec4(uid, v)
    gl.glUniform4fv(uid, 1, v.x, v.y, v.z, v.w)
end

function glUniformColor(uid, v)
    gl.glUniform4fv(uid, 1, v.r, v.g, v.b, v.a)
end

function Shader:getUL(ul)
    return gl.glGetUniformLocation(self.ids.program, ul)
end

function Shader:attachShader(id)
    if gl.glIsShader(id) == gl.GL_TRUE then
        gl.glAttachShader(self.ids.program, id)
    end
end

function Shader:buildShader(id, shaderType, code, files, lines, file, ext)
    if code == nil then return 0 end

    if id and gl.glIsShader(id) == gl.GL_TRUE then
        gl.glDeleteShader(id)
    end

    id = gl.glCreateShader(shaderType)
    assert(id)

    print(gl.getGlslVersionDefine())
    
    code = gl.getGlslVersionDefine()..code

    gl.glShaderSource(id, code)
    gl.glCompileShader(id)

    local error = gl.glGetShaderiv(id, gl.GL_COMPILE_STATUS)
    if error == gl.GL_FALSE then
        local errors = gl.glGetShaderInfoLog(id)
        errors = errors:gsub(':(%d*):',
            function (line)
                line = tonumber(line) - 3
                local startLine = 0
                for i,nblines in ipairs(lines) do
                    file = files[i]
                    if line <= startLine + nblines then
                        break
                    end
                    startLine = startLine + nblines
                end
                return ':'..(line-startLine)..':'
            end)

        print(NL..'./'..file..' '..errors)
        assert(false)
    end

    return id
end

function Shader:release()
    if gl.glIsProgram(self.ids.program) == gl.GL_TRUE then

        if self.ids.vert and gl.glIsShader(self.ids.vert) == gl.GL_TRUE then
            gl.glDetachShader(self.ids.program, self.ids.vert)
            gl.glDeleteShader(self.ids.vert)
        end

        if self.ids.frag and gl.glIsShader(self.ids.frag) == gl.GL_TRUE then
            gl.glDetachShader(self.ids.program, self.ids.frag)
            gl.glDeleteShader(self.ids.frag)
        end

        if self.ids.geo and gl.glIsShader(self.ids.geo) == gl.GL_TRUE then
            gl.glDetachShader(self.ids.program, self.ids.geo)
            gl.glDeleteShader(self.ids.geo)
        end

        gl.glDeleteProgram(self.ids.program)

    end
end

function Shader:use(mesh)    
    gl.glUseProgram(self.ids.program)
    self:setUniforms(mesh)
end

function Shader:setUniforms(mesh, useTexture)
    local transpose = gl.GL_TRUE    

    self:pushToShader({projectionViewMatrix=pvMatrix()})
    self:pushToShader({modelMatrix=mesh.modelMatrix or modelMatrix()})

    self:pushToShader({fillColor=fill()})
    self:pushToShader({strokeColor=stroke()})

    if system.camera then
        self:pushToShader({cameraPosition=system.camera:eye()})
    end

    if mesh.texture and mesh.texture ~= mesh.defaultTexture then
        self:pushToShader({useTexture=true})
    else
        self:pushToShader({useTexture=false})
    end

    if mesh.colorMode == 'fill' then
        self:pushToShader({useUniformColor=2})
    elseif mesh.colorMode == 'uniform' then
        self:pushToShader({useUniformColor=1})
    else
        self:pushToShader({useUniformColor=0})
    end

    if light() and #lights > 0 then
        self:pushToShader(currentMaterial, 'material')
        self:pushTableToShader(lights, 'lights', 'useLight')
    else
        self:pushToShader({useLight=false})
    end

    self:pushToShader({useCellShading=config.cellShading})

    if mesh.uniforms then
        self:pushToShader(mesh.uniforms)
    end
end

function Shader:unuse()
    gl.glUseProgram(0)
end
