-- Shader

Shader = class('shader')
Shader.ids = {}

function Shader.setup()
    shaders = {}

    Shader.shadersPath = 'core/luajit/shaders'

    shaders['standard'] = Shader('standard',
        {'include.shader', 'standard.vert'},
        {'include.shader', 'standard.frag'})

    shaders['lines2d'] = Shader('standard',
        {'include.shader', 'lines2d.vert'},
        {'include.shader', 'lines2d.frag'},
        {'include.shader', 'lines2d.geo'})    

    shaders['text'] = Shader('text',
        {'include.shader', 'text.vert'},
        {'include.shader', 'text.frag'})

    shaders['filter'] = Shader('filter',
        {'include.shader', 'filter.vert'},
        {'include.shader', 'filter.frag'})
end

function shader(v, f)
    return Shader('', v, f)
end

function Shader:init(name, vertFile, fragFile, geoFile)
    assert(vertFile and fragFile)

    self.name = name

    self.vert = self:loadCode(vertFile, 'vert')
    self.frag = self:loadCode(fragFile, 'frag')

    if geoFile then
        self.geo  = self:loadCode(geoFile, 'geo')
    else
        self.vert = (self.vert
            :replace("vPositionG", "vPosition")
            :replace("vColorG", "vColor"))
    end

    assert(self.vert and self.frag)

    self.ids = {
        program = 0,
        vert = 0,
        frag = 0,
        geo = 0
    }

    self.uniforms = {
    }

    self:compile()
end

local function loadFile(file, ext)
    local path = Shader.shadersPath..'/'..file
    if isFile(path) then
        code = load(path)
    else
        code = file
    end
    return code
end

function Shader:loadCode(file)
    if file == nil then return end

    local code = nil
    if type(file) == 'table' then
        code = ""
        for i,file in ipairs(file) do
            code = code..'\n'..loadFile(file)
        end
    else
        code = loadFile(file)
    end

    return code
end

function Shader:compile()
    self.ids.vert = self:buildShader(self.ids.vert, gl.GL_VERTEX_SHADER  , self.vert, self.name, 'vert')
    self.ids.frag = self:buildShader(self.ids.frag, gl.GL_FRAGMENT_SHADER, self.frag, self.name, 'frag')
    self.ids.geo  = self:buildShader(self.ids.geo , gl.GL_GEOMETRY_SHADER, self.geo , self.name, 'geo')

    if gl.glIsProgram(self.ids.program) == gl.GL_TRUE then
        gl.glDeleteProgram(self.ids.program)
    end

    self.ids.program = gl.glCreateProgram()
    assert(self.ids.program ~= nil)

    self:attachShader(self.ids.vert)
    self:attachShader(self.ids.frag)
    self:attachShader(self.ids.geo)

    gl.glBindAttribLocation(self.ids.program, LOCATION_VERTICES, "position")
    gl.glBindAttribLocation(self.ids.program, LOCATION_NORMALS, "normal")
    gl.glBindAttribLocation(self.ids.program, LOCATION_COLORS, "color")
    gl.glBindAttribLocation(self.ids.program, LOCATION_TEX_COORDS, "texCoord")
    gl.glBindAttribLocation(self.ids.program, LOCATION_INSTANCE_MODEL_MATRIX, "modelMatrixInstance")
    gl.glBindAttribLocation(self.ids.program, LOCATION_INSTANCE_COLORS, "colorInstance")
    gl.glBindAttribLocation(self.ids.program, LOCATION_INSTANCE_WIDTH, "widthInstance")

    gl.glLinkProgram(self.ids.program)

    local error = gl.glGetProgramiv(self.ids.program, gl.GL_LINK_STATUS)    
    assert(error == gl.GL_TRUE, gl.glGetProgramInfoLog(self.ids.program))
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
        local uid = self:getUL(k)
        if uid ~= -1 then
            local typ = typeOf(v)
            if typ == 'number' then
                if k:startWith('use') then
                    gl.glUniform1i(uid, v)
                else
                    gl.glUniform1fv(uid, 1, v)
                end

            elseif typ == 'vec2' then
                glUniformVec2(uid, v)

            elseif typ == 'vec3' or typ == 'Vector' then
                glUniformVec3(uid, v)

            elseif typ == 'vec4' then
                glUniformVec4(uid, v)

            elseif typ == 'color' or typ == 'Color' then
                glUniformColor(uid, v)

            elseif typ == 'matrix' then
                local transpose = gl.GL_TRUE
                if matrix == glm_matrix then
                    transpose = gl.GL_FALSE
                end
                gl.glUniformMatrix4fv(uid, 1, transpose, v)

            elseif typ == 'boolean' then
                if v == true then
                    gl.glUniform1i(uid, 1)
                else
                    gl.glUniform1i(uid, 0)
                end

            else
                assert(false, "shader : unmanaged type "..typ.." for "..k)
            end
        else
            warning(false, self.name.." : unknown arg "..k)
        end
    end
end

function glUniformVec2(uid, v)
    local vp = ffi.new('GLfloat[2]', {
            v.x,
            v.y})
    gl.glUniform2fv(uid, 1, vp)
end

function glUniformVec3(uid, v)
    local vp = ffi.new('GLfloat[3]', {
            v.x,
            v.y,
            v.z})
    gl.glUniform3fv(uid, 1, vp)
end

function glUniformVec4(uid, v)
    local vp = ffi.new('GLfloat[4]', {
            v.x,
            v.y,
            v.z,
            v.w})
    gl.glUniform4fv(uid, 1, vp)
end

function glUniformColor(uid, v)
    local vp = ffi.new('GLfloat[4]', {
            v.r/255,
            v.g/255,
            v.b/255,
            v.a/255})
    gl.glUniform4fv(uid, 1, vp)
end

function Shader:getUL(ul)
    return gl.glGetUniformLocation(self.ids.program, ul)
end

function Shader:attachShader(id)
    if gl.glIsShader(id) == gl.GL_TRUE then
        gl.glAttachShader(self.ids.program, id)
    end
end

function Shader:buildShader(id, shaderType, code, file, ext)
    if code == nil then return 0 end

    if gl.glIsShader(id) == gl.GL_TRUE then
        gl.glDeleteShader(id)
    end

    id = gl.glCreateShader(shaderType)
    assert(id)

    gl.glShaderSource(id, code)
    gl.glCompileShader(id)

    local error = gl.glGetShaderiv(id, gl.GL_COMPILE_STATUS)
    assert(error == gl.GL_TRUE, file .. '.' .. ext .. ' => ' .. gl.glGetShaderInfoLog(id))

    return id
end

function Shader:release()
    gl.glDetachShader(self.ids.program, self.ids.vert)
    gl.glDetachShader(self.ids.program, self.ids.frag)
    gl.glDetachShader(self.ids.program, self.ids.geo)

    gl.glDeleteShader(self.ids.vert)
    gl.glDeleteShader(self.ids.frag)
    gl.glDeleteShader(self.ids.geo)

    gl.glDeleteProgram(self.ids.program)
end

function Shader:use(mesh)    
    gl.glUseProgram(self.ids.program)
    self:setUniforms(mesh)
end

function Shader:setUniforms(mesh, useTexture)
    local transpose = gl.GL_TRUE
    if matrix == glm_matrix then
        transpose = gl.GL_FALSE
    end

    self:pushToShader({projectionViewMatrix=pvMatrix()})
    self:pushToShader({modelMatrix=mesh.modelMatrix or modelMatrix()})
    
    self:pushToShader({fillColor=fill()})
    self:pushToShader({strokeColor=fill()})
    
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

    if lightMode() and #lights > 0 then
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