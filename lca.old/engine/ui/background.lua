class('UIBackground', UI)

function UIBackground:init(clr)
    UI.init(self)
	self.clr = clr
end

function UIBackground:draw()
	background(self.clr)
end
