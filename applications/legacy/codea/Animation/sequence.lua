-- See the 'startAnimations' method for example use of tween.sequence()

Sequence = class(Test)

function Sequence:init()
    Test.init(self, "Sequences")
end

function Sequence:setup()
    Test.setup(self)
    
    print("Sequences allow you to chain multiple tweens together")

    print("tween.sequence( t1, t2, ... tN )")
    
    self.c1 = Circle( 100, HEIGHT/2 + 150 )
end

function Sequence:startAnimations()
    Test.startAnimations(self)
    
    -- Here we create and store several tweens
    local l = tween.easing.linear
    
    -- Move along x
    local t1 = tween( 1.0, self.c1, {x = WIDTH - 100}, l, 
                    function() 
                        print("tween 1 finished") 
                    end )
    
    -- Move along y
    local t2 = tween( 1.0, self.c1, {y = HEIGHT/2 - 150}, l,
                    function()
                        print("tween 2 finished")
                    end )
    
    -- Grow in size
    local t3 = tween( 1.0, self.c1, {size = 200}, l,
                    function()
                        print("tween 3 finished")
                    end )
    
    -- Then we pass them to tween.sequence()
    --  all but the first tween will be disabled, 
    --  and they will be chained together
    tween.sequence( t1, t2, t3 )
end

function Sequence:resetAnimations()
    Test.resetAnimations(self)
    
    self.c1:reset()
end

function Sequence:draw()
    self.c1:draw()
end
