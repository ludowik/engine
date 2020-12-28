class('ColorPicker', UI, Bind)

function ColorPicker:init(var, clr, ...)
    UI.init(self, var)
    self.clr = Color.from(clr)
    
    self:bind(var, self.clr, ...)
end

function ColorPicker:initImage()
    if self.saturation == nil or self.needUpdate then 
        local width = self.size.x

        -- current color
        local h, s, l, a = rgb2hsl(self.clr)

        -- saturation and light
        local maxDist = vec2(0, 0):dist(vec2(width, width))

        self.saturation = self.saturation or image(width, width)
        for x=1,width do
            for y=1,width do
                local sDist = vec2(x, y):dist(vec2(0, 0))
                local lDist = vec2(x, y):dist(vec2(0, width))

                local clr = hsl(h, 
                    (sDist)/(maxDist),
                    (lDist)/(maxDist),
                    a)

                self.saturation:set(x, y, clr)
            end
        end
    end

    if self.hue == nil or self.needUpdate then 
        local len = self.size.x - 20

        self.hue = self.hue or image(len, 20)
        for i=1,len do
            local clr = hsl(i/len, 1, 0.5, 1)
            for y=1,20 do
                self.hue:set(i, y, clr)
            end
        end
    end

    self.needUpdate = false
end

function ColorPicker:computeSize()
    self.size:set(128, 128+20)
end

function ColorPicker:draw()
    self:initImage()

    local width  = self.size.x
    local height = self.size.y

    local len = self.size.x - 20

    rectMode(CORNER)

    -- current color
    local h, s, l, a = rgb2hsl(self.clr)
    stroke(white)
    strokeWidth(1)
    fill(self.clr)
    rect(0, width, 20, 20)

    -- hue
    spriteMode(CORNER)
    sprite(self.hue, 20, width)

    -- saturation
    sprite(self.saturation, 0, 0)
end

function ColorPicker:touched(touch)
    if isButtonDown(1) then
        local x = touch.x - self.absolutePosition.x
        local y = touch.y - self.absolutePosition.y

        local width  = self.size.x
        local height = self.size.y

        if x > 20 and x < width and y > width and y < width + 20 then
            local x = touch.x - self.absolutePosition.x - 20
            local y = touch.y - self.absolutePosition.y - self.size.x

            local _, s, l, a = rgb2hsl(self.clr)
            local h = rgb2hsl(self.hue:get(x, y))
            
            self.clr = hsl(h, s, l , a)
            
            self:setValue(self.clr)
            
            self.needUpdate = true
            
        elseif x > 0 and x < width and y > 0 and y < width then
            local x = touch.x - self.absolutePosition.x
            local y = touch.y - self.absolutePosition.y

            self.clr = self.saturation:get(x, y)
            
            self:setValue(self.clr)
            
            self.needUpdate = true
        end
    end
end
