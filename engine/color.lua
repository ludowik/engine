class 'Color'

function Color:init(r, g, b, a)
    self.r = r
    self.g = g or r
    self.b = b or r
    self.a = a or 1
end

black = Color(0)
white = Color(1)

red   = Color(1, 0, 0)
green = Color(0, 1, 0)
blue  = Color(0, 0, 1)
