local RendererInterface = class 'RendererInterface'

function RendererInterface.setup()
end

function RendererInterface.load()
end

function RendererInterface:init()
end

function RendererInterface:release()
end

function RendererInterface:vsync()
end

function RendererInterface:defaultContext()
end

function RendererInterface:viewport(x, y, w, h)
end

function RendererInterface:clear()
end

function RendererInterface:swap()
end

function RendererInterface:blendMode(mode)
end

function RendererInterface:depthMode(mode)
end

function RendererInterface:cullingMode(mode)
end

function RendererInterface:clip(x, y, w, h)
end

function RendererInterface:getFont()
end

function RendererInterface:setFontName(name)
    return name
end

function RendererInterface:setFontSize(size)
    return size
end

function RendererInterface:getText(text)
end

function RendererInterface:render(shader, drawMode, img, x, y, z, w, h, d, nInstances)
end
