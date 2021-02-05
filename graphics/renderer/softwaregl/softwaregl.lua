--class 'GL' : extends()

--function GL:load()
--    self.flag = 0

--    self.GL_TRIANGLES = 'triangles'
--    self.GL_TRIANGLE_STRIP = 'triangleStrip'
--end

--function GL:unload()
--end

--function GL:createContext(window)
--    self.context = sdl.SDL_CreateRenderer(window, -1, 0)
--    return self.context
--end

--function GL:deleteContext(context)
--    return sdl.SDL_DestroyRenderer(context)
--end

--function GL:vsync(interval)
--    return interval
--end

--function GL:blendMode(mode)
--end

--function GL:cullingMode(mode)
--end

--function GL:depthMode(mode)
--end

--function GL:clip(x, y, w, h)
--end

--function GL:defaultContext()
--end

--function GL:viewport(x, y, w, h)
--    local size = ffi.new('SDL_Rect',
--        x, y,
--        w, h)

--    sdl.SDL_RenderSetViewport(self.context, size)
--end

--function GL:clear(clr)
--    sdl.SDL_SetRenderDrawColor(self.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)
--    sdl.SDL_RenderClear(self.context)
--end

--function GL:swap()
--    sdl.SDL_RenderPresent(self.context)
--end

--class 'SoftwareGL' : extends(GL)

--MeshRender = class 'RendererInterface.Software' : extends(MeshRender)

--function MeshRender:init()
--    self.pos = vec3()
--    self.size = matrix()
--end

--function MeshRender:render(shader, drawMode, img, x, y, z, w, h, d, nInstances)
--    assert(shader)
--    assert(drawMode)

--    x = x or 0
--    y = y or 0
--    z = z or zLevel()

--    w = w or 1
--    h = h or 1
--    d = d or 1

--    self.pos:set(x, y, z)
--    self.size = matrix():scale(w, h, d)

--    if drawMode == sgl.GL_TRIANGLES then
--        local n
--        if self.indices and #self.indices > 0 then
--            n = #self.indices
--        else
--            n = #self.vertices
--        end

--        local clr = white
--        sdl.SDL_SetRenderDrawColor(sgl.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)

--        local a, b, c
--        for i=0,n/3-1 do
--            if self.indices then
--                a = self.vertices[self.indices[i*3+1]]
--                b = self.vertices[self.indices[i*3+2]]
--                c = self.vertices[self.indices[i*3+3]]
--            else
--                a = self.vertices[i*3+1]
--                b = self.vertices[i*3+2]
--                c = self.vertices[i*3+3]
--            end

--            a = self.size:mulVector(a)
--            b = self.size:mulVector(b)
--            c = self.size:mulVector(c)

--            a = a + self.pos
--            b = b + self.pos
--            c = c + self.pos

--            sdl.SDL_RenderDrawLine(sgl.context, a.x, a.y, b.x, b.y)
--            sdl.SDL_RenderDrawLine(sgl.context, b.x, b.y, c.x, c.y)
--            sdl.SDL_RenderDrawLine(sgl.context, c.x, c.y, a.x, a.y)
--        end

--    elseif drawMode == sgl.GL_TRIANGLE_STRIP then
--        local n
--        if self.indices then
--            n = #self.indices
--        else
--            n = #self.vertices
--        end

--        local clr = white
--        sdl.SDL_SetRenderDrawColor(sgl.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)

--        local a, b, c
--        for i=0,n-3 do
--            if self.indices then
--                a = self.vertices[self.indices[i*3+1]]
--                b = self.vertices[self.indices[i*3+2]]
--                c = self.vertices[self.indices[i*3+3]]
--            else
--                a = self.vertices[i*3+1]
--                b = self.vertices[i*3+2]
--                c = self.vertices[i*3+3]
--            end

--            a = self.size:mulVector(a)
--            b = self.size:mulVector(b)
--            c = self.size:mulVector(c)

--            a = a + self.pos
--            b = b + self.pos
--            c = c + self.pos

--            sdl.SDL_RenderDrawLine(sgl.context, a.x, a.y, b.x, b.y)
--            sdl.SDL_RenderDrawLine(sgl.context, b.x, b.y, c.x, c.y)
--            sdl.SDL_RenderDrawLine(sgl.context, c.x, c.y, a.x, a.y)
--        end
        
--    else
--        assert()
--    end
--end
