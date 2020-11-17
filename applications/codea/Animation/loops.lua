-- See the 'startAnimations' method for example use of loops

Loops = class(Test)

function Loops:init()
    -- you can accept and set parameters here
    Test.init(self, "Loops")
end

function Loops:setupTest()
    Test.setupTest(self)

    print("This test shows the three looping varieties")

    print("1. tween.loop.once")
    print("2. tween.loop.forever")
    print("3. tween.loop.pingpong")

    -- Create three circles spaced vertically
    self.c1 = Circle( 100, HEIGHT/2 + 150 )
    self.c2 = Circle( 100, HEIGHT/2 )
    self.c3 = Circle( 100, HEIGHT/2 - 150 )
end

function Loops:startAnimations()
    Test.startAnimations(self)

    -- In order to specify loops, the options parameter is replaced
    -- with a table containing two keys: 'easing' and 'loop'
    -- where easing specifies the easing type, and loop specifies the loop type

    local destX = WIDTH - 100

    -- tween.loop.once is the default - play once
    tween( 1.0, self.c1, { x = destX }, { easing = tween.easing.linear,
                                          loop = tween.loop.once } )

    -- tween.loop.forever plays the animation over and over again
    tween( 1.0, self.c2, { x = destX }, { easing = tween.easing.linear,
                                          loop = tween.loop.forever } )

    -- tween.loop.pingpong plays the animation in reverse, and then repeats
    tween( 1.0, self.c3, { x = destX }, { easing = tween.easing.linear,
                                          loop = tween.loop.pingpong } )
end

function Loops:resetAnimations()
    Test.resetAnimations(self)

    self.c1:reset()
    self.c2:reset()
    self.c3:reset()
end

function Loops:draw()
    self.c1:draw()
    self.c2:draw()
    self.c3:draw()
end

