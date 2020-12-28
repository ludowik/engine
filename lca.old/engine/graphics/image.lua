class('image')

function image.setup()
    image.tmp_color = color()
end

function image.getPath(imageName, ext)
    local path = getImagePath()
    return path..'/'..imageName:replace(':', '/')..(ext or '.png')
end

function image:init(...)
    local args = {...}

    local imageName, w, h = args[1]
    local path
    if type(imageName) == 'string' then
        path = self.getPath(imageName)
        if fs.getInfo(path) == nil then
            path = self.getPath(imageName, '.jpg')
            if fs.getInfo(path) == nil then
                path = nil
                w, h = args[2], args[3]
            end
        end
    else
        w, h = args[1], args[2]
    end

    w = w or 32
    h = h or w

    if path then    
        self.imageData = lca.image.newImageData(path)
        self:flip()

        self.image = graphics.newImage(self.imageData)

        self.width = self.image:getWidth()
        self.height = self.image:getHeight()

    else
        local dpiScale = love.window.getDPIScale()
        self.imageData = lca.image.newImageData(w*dpiScale, h*dpiScale)
        self.image = graphics.newImage(self.imageData)

        self.width = w
        self.height = h
    end

    self.upToDate = false
end

function image:flip(to)
    local pointer = self.imageData:getPointer()
    local size = self.imageData:getSize()
    local w = self.imageData:getWidth()
    local h = self.imageData:getHeight()

    bytesPerPixel = size / w / h

    local from = ffi.cast('unsigned char*', pointer)
    to = ffi.cast('unsigned char*', to or pointer)

    local i, j
    for y = 1, h/2 do
        for x = 1, w do
            i = (w * (y-1) + (x-1)) * bytesPerPixel
            j = (w * (h-y) + (x-1)) * bytesPerPixel

            if bytesPerPixel == 1 then
                to[i+0], to[j+0] = from[j+0], from[i+0]

            elseif bytesPerPixel == 3 then
                to[i+0], to[j+0] = from[j+0], from[i+0]
                to[i+1], to[j+1] = from[j+1], from[i+1]
                to[i+2], to[j+2] = from[j+2], from[i+2]

            elseif bytesPerPixel == 4 then
                to[i+0], to[j+0] = from[j+0], from[i+0]
                to[i+1], to[j+1] = from[j+1], from[i+1]
                to[i+2], to[j+2] = from[j+2], from[i+2]
                to[i+3], to[j+3] = from[j+3], from[i+3]
            end
        end
    end
end

function image:save(imageName)
    local path = self.getPath(imageName)
    local imageData = lca.image.newImageData(self.width, self.height)
    self:flip(imageData:getPointer())

    imageData:encode('png', path)
end

function image:update()
    if self.upToDate == false then
        self.upToDate = true
        self.image:replacePixels(self.imageData)
    end
end

function image:draw(x, y, r, sx, sy)
    self:update()
    graphics.draw(self.image, x, y, r, sx, sy)
end

function image:getContext()
    local w, h = self.width, self.height
    if self.canvas == nil then
        self.canvas = graphics.newCanvas(w, h)

        graphics.reset()
        graphics.setCanvas(self.canvas)
        graphics.draw(self.image)
    end
    return self.canvas
end

function image:resetContext()
    self.imageData = self.canvas:newImageData()
    self.upToDate = false    
end

function image:set(x, y, r, g, b, a)
    self.upToDate = false

    if type(x) == 'table' then
        r, g, b, a = y, r, g, b
        x, y = x.x, x.y
    end
    if type(r) == 'table' then
        r, g, b, a = r.r, r.g, r.b, 1 --r.a
    end

    if x > 0 and x < self.width and y > 0 and y < self.height then
        self.imageData:setPixel(x-1, y-1, r, g, b, a)
    end
end

function image:get(x, y, clr)
    clr = clr or image.tmp_color

    local r, g, b, a = self.imageData:getPixel(x-1, y-1)
    clr.r = r
    clr.g = g
    clr.b = b
    clr.a = a

    return clr
end
