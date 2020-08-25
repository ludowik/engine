class('Background', UI)

function Background:init(clr)
    UI.init(self)
	self.bgColor = clr
end

function Background:draw()
	background(self:getBgColor())
end
