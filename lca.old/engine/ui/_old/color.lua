--UIColor = class('UIColor', LabelExp)

--function UIColor:init(...)
--	self:public(LabelExp, ...)
--end

--function UIColor:draw()
--	fill(_G[self.label])

--	self:drawRect()
--	self:drawLabel('pick color')
--end

--function UIColor:click()
--	local clr = _G[self.label]
--	system.parameters:pushScene(ColorPicker('pick a color', clr))
--end

-- color picker
--UIColorPicker = class('UIColorPicker', Object)

--function UIColorPicker:init(clr)
--	self:public(Object)
--	self:setSize(2, 2)

--	self.clr = clr
--end

--function UIColorPicker:draw()
--	local width = self.size.x
	
--	-- background
--	self.fillColor = black
--	self:drawRect()
	
--	-- current color
--	local h, s, l, a = rgb2hsl(self.clr)
--	fill(self.clr)
--	rect(0, width-20, 20, 20)
	
--	-- saturation and light
--	local maxDist = vec2(0, 0):dist(vec2(width, width))
			
--	local img = image(width, width)
--	for x=1,width do
--		for y=1,width do
--			local sDist = vec2(x, y):dist(vec2(0, 0))
--			local lDist = vec2(x, y):dist(vec2(0, width))
			
--			local clr = hsl(h, 
--				(sDist)/(maxDist),
--				(lDist)/(maxDist),
--				a)
			
--			img:set(x, y, clr)
--		end
--	end

--	-- hue
--	local m = mesh()

--	local xm = width / 2
--	local ym = xm

--	local r = (width-10) / 2
--	for i=1,361 do
--		local clr = hsl(i/360, 1, 0.5, 1)
--		table.add(m.vertices, vec3(r*cos(rad(i)), r*sin(rad(i))))
--		m:color(i, clr)
--	end

--	pushMatrix()
--	translate(xm, ym)

--	strokeWidth(12)
--	m:draw('line2D_strip')
--	popMatrix()

--	translate(xm, ym)
--	scale(0.5, 0.5)
--	spriteMode(CENTER)
--	sprite(img, 0, 0)
--end

-- TODO 
-- uiColor + uiColorPicker

Class('UIColor', Widget)

function UIColor:UIColor(label, clr)
    self:Widget(label)
    
    self:setGridSize(2, 1)
    self.clr = clr or white
end

function UIColor:initImage()
    if self.image == nil or update then 
        local width = self.size.x

        -- current color
        local h, s, l, a = rgb2hsl(self.clr)

        -- saturation and light
        local maxDist = vec2(0, 0):dist(vec2(width, width))

        local img = image(width, width)
        for x=1,width do
            for y=1,width do
                local sDist = vec2(x, y):dist(vec2(0, 0))
                local lDist = vec2(x, y):dist(vec2(0, width))

                local clr = hsl(h, 
                    (sDist)/(maxDist),
                    (lDist)/(maxDist),
                    a)

                img:set(x, y, clr)
            end
        end

        self.image = img
    end

    return self.image
end

function UIColor:drawRect()
    rect(0, 0, self.size.x, self.size.y)
end

function UIColor:draw()
    local width = self.size.x

    -- background
    self.fillColor = black
    self:drawRect()

    -- current color
    local h, s, l, a = rgb2hsl(self.clr)
    fill(self.clr)
    rect(0, width-20, 20, 20)

    local img = self:initImage()

    -- hue
    local m = mesh()

    local xm = width / 2
    local ym = xm

    local r = (width-10) / 2
    m:resize(360)
    for i=1,360 do
        local clr = hsl(i/360, 1, 0.5, 1)
        m:vertex(i, vec2(r*cos(rad(i)), r*sin(rad(i))))
        m:color(i, clr)
    end

    pushMatrix()
    translate(xm, ym)

    strokeWidth(12)
    m:draw('line_strip')
    popMatrix()

    translate(xm, ym)
    scale(0.5, 0.5)
    spriteMode(CENTER)
    sprite(img, 0, 0)
end
