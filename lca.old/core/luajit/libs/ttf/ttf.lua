local ttfClass = class()

function ttfClass.setup()
end
ttfClass.setup()

function ttfClass:init(defs)
    ttfClass.defs = defs
    ttfClass.defs.TTF_Init()

    self.fontName = defaultFontName
    self.fontSize = defaultFontSize

    self:initFont(self.fontName, self.fontSize)

    --self.renderFunc = defs.TTF_RenderText_Solid
    --self.renderFunc = defs.TTF_RenderText_Shaded
    self.renderFunc = defs.TTF_RenderText_Blended
end

function ttfClass:release()   
    ttfClass.defs.TTF_Quit()
end

function ttfClass:__tostring()
    if self.txt == nil then
        return self.fontName..'.'..self.fontSize
    end
    return self.fontName..'.'..self.fontSize..'.'..self.txt
end

function ttfClass:initFont(fontName, fontSize)
    self.fontName = fontName or self.fontName
    self.fontSize = fontSize or self.fontSize

    self.txt = nil
    self.currentFont = resources.get('fontTTF', 
        self,
        ttfClass.createFont,
        ttfClass.releaseFont,
        false)
end

function ttfClass.createFont(self)
    local fontPath = getFontPath(self.fontName)
    if isFile(fontPath) == false then
        fontPath = getFontPath(defaultFontName)
    end
    return ttfClass.defs.TTF_OpenFont(fontPath, self.fontSize)
end

function ttfClass.releaseFont(res)
    ttfClass.defs.TTF_CloseFont(res)
end

local function createSDLColor()
    return ffi.new('SDL_Color', {0, 0, 0, 0})
end

local function releaseSDLColor(res)
    res = nil
end

function ttfClass.createImage(ref)
    local color = resources.get('sdl_color', 'color',
        createSDLColor,
        releaseSDLColor)
    
    if ref.currentFont ~= NULL then
        local render = ref.renderFunc(ref.currentFont, ref.txt, color)
        if render ~= NULL then
            local image = image()
            image.width = render.w
            image.height = render.h
            
            image:genTexture()
            
            local w = image.width
            local h = image.height
            
            local pixels = ffi.new('GLubyte[?]', w*h*4)
            ffi.C.memset(pixels, 0, ffi.sizeof('GLubyte')*w*h*4)
            
            local buffer = ffi.cast('GLuint*', render.pixels)
            
            local index = 0
            for i=1,w do
                for j=1,h do
                    if buffer[index] > 0 then
                        pixels[index*4] = 255
                        pixels[index*4+1] = 255
                        pixels[index*4+2] = 255
                        pixels[index*4+3] = buffer[index]
                    end
                    index = index + 1
                end
            end
            image:loadPixels(pixels, gl.GL_RGBA, gl.GL_RGBA)
            
            sdl.SDL_FreeSurface(render)

            return image
        end
    end
end

function ttfClass:style(font, style)
    -- TTF_STYLE_NORMAL : normal ;
    -- TTF_STYLE_BOLD : gras ;
    -- TTF_STYLE_ITALIC : italique ;
    -- TTF_STYLE_UNDERLINE
    self.defs.TTF_SetFontStyle(font, style)
end

-- TODEL
--function ttfClass:getWidth(str)
--    local w, h = system.textSize(self, str)
--    return w
--end

--function ttfClass:getHeight(str)
--    local w, h = system.textSize(self, str)
--    return h
--end

local loader = {}
function loader.load()
    ttf = ttfClass(cload(nil, 'SDL2_ttf'))
    return ttf
end

function loader.init()
end

return loader
