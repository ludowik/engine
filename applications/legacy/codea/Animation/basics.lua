-- See the 'startAnimations' method for example use of tween()

Basics = class(Test)

function Basics:init()
    Test.init(self, "Basics")
end

function Basics:setup()
    Test.setup(self)
    
    print("A demo showing how to use basic tweens")
    
    print("1. tween.easing.linear")
    print("2. tween.easing.quadInOut")
    print("3. tween.easing.bounceOut")
    
    -- Create three circles spaced vertically
    self.c1 = Circle( 100, HEIGHT/2 + 150 )
    self.c2 = Circle( 100, HEIGHT/2 )
    self.c3 = Circle( 100, HEIGHT/2 - 150 )
end

function Basics:startAnimations()   
    -- Call super
    Test.startAnimations(self)
     
    -- Start animating them
    local destX = WIDTH - 100
    
    tween( 1.0, self.c1, { x = destX } )
    tween( 1.0, self.c2, { x = destX }, tween.easing.quadInOut )
    tween( 1.0, self.c3, { x = destX }, tween.easing.bounceOut, 
           function () 
             print("Animation Ended")
           end  )
end

function Basics:resetAnimations()
    -- Call super
    Test.resetAnimations(self)
    
    self.c1:reset()
    self.c2:reset()
    self.c3:reset()
end

function Basics:draw()    
    self.c1:draw()
    self.c2:draw()
    self.c3:draw()
end

