class('image')

function image.setup()
end

function image.getPath(imageName, ext)
    local path = getImagePath()
    return path..'/'..imageName:replace(':', '/')..'.'..(ext or 'png')
end

function image.getImage(imageName)
    return resources.get('image',
        imageName,
        image,
        image.release,
        true)
end

function image:init(...)
    local args = {...}

    local imageName, w, h = args[1]
    local path
    
    local imageNameType = typeof(imageName)
    
    if imageNameType == 'string' then
        path = self.getPath(imageName)
        if fs.getInfo(path) == nil then
            path = self.getPath(imageName, 'jpg')
            if fs.getInfo(path) == nil then
                path = nil
                w, h = args[2], args[3]
            end
        end
    elseif imageNameType == 'userdata' then
        path = imageName
    elseif imageNameType == 'image' then
        return imageName
    else
        w, h = args[1], args[2]
    end

    w = w or 32
    h = h or w

    if path then    
        self.imageData = love.image.newImageData(path)
        self:flip()

        self.image = love.graphics.newImage(self.imageData)

        self.width = self.image:getWidth()
        self.height = self.image:getHeight()

    else
        local dpiScale = love.window.getDPIScale()
        self.imageData = love.image.newImageData(w*dpiScale, h*dpiScale)
        self.image = love.graphics.newImage(self.imageData)

        self.width = w
        self.height = h
    end

    self.upToDate = false
end

function image:copy(x, y, w, h)
    x = x or 0
    y = y or 0

    w = w or self.width
    h = h or self.height

    local img = image(w, h)

    local from = self
    local to = img

    for i=1,w do
        for j=1,h do
            to:set(i, j, from:get(x+i, y+j):unpack())
        end
    end
    
    img:update()

    return img
end

function image:release()
    self.image:release()
    self.imageData:release()
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

            else
                assert()
            end
        end
    end
end

function image:save(imageName)
    local path = self.getPath(imageName)
    local imageData = love.image.newImageData(self.width, self.height)
    self:flip(imageData:getPointer())

    imageData:encode('png', path)
end

function image:update()
    if self.upToDate == false then
        self.upToDate = true
        self.image:replacePixels(self.imageData)
    end
end

function image:draw(x, y, sx, sy)
    sprite(self, x, y, sx, sy)
end

function image:getContext()
    local w, h = self.width, self.height
    if self.canvas == nil then
        self.canvas = love.graphics.newCanvas(w, h)

        love.graphics.reset()
        love.graphics.setCanvas(self.canvas)
        love.graphics.draw(self.image)
    end
    return self.canvas
end

function image:resetContext()
    self.imageData = self.canvas:newImageData()
    self.upToDate = false    
end

function image:set(x, y, r, g, b, a)
    if self.upToDate then self.upToDate = false end

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
    clr = clr or Color()

    if x > 0 and y > 0 and x < self.width and y < self.height then
        local r, g, b, a = self.imageData:getPixel(x-1, y-1)
        clr.r = r
        clr.g = g
        clr.b = b
        clr.a = a
    end

    return clr
end
