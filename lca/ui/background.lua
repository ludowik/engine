class('Background', UI)

function Background:init(clr)
    UI.init(self)
	self.clr = clr
end

function Background:draw()
	background(self.clr)
end
