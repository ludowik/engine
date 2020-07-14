-- See the 'startAnimations' method for an example of tween.path()

Path = class(Test)

function Path:init()
    Test.init(self, "Path")
end

function Path:setup()
    Test.setup(self)
    
    print("Path allows you to pass an array of target values, which are interpolated with a spline")

    print("tween.path( duration, subject, targetArray, options, callback )")
    
    self.c1 = Circle( 100, HEIGHT/2 + 150 )
end

function Path:startAnimations()
    Test.startAnimations(self)
    
    local p1 = { x = 100, y = HEIGHT/2 + 150, size = 100 }
    local p2 = { x = WIDTH - 100, y = HEIGHT/2 + 150, size = 100 }
    local p3 = { x = WIDTH - 100, y = HEIGHT/2 - 150, size = 200 }
    local p4 = { x = 100, y = HEIGHT/2 - 150, size = 100 }
    
    tween.path( 4.0, self.c1, {p1,p2,p3,p4,p1}, {loop=tween.loop.forever} )
end

function Path:resetAnimations()
    Test.resetAnimations(self)
    
    self.c1:reset()
end

function Path:draw()
    self.c1:draw()
end
