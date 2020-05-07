class 'Mouse'

function Mouse:init()
    self.x = 0
    self.y = 0
    
    self.isTouch = false
end

function Mouse:__tostring()
    return self.x..', '..self.y..' ('..(self.isTouch and 'true' or 'false')..')'
end

mouse = Mouse()
