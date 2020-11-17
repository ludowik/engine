Test = class()

function Test:init(title)
    -- you can accept and set parameters here
    self.name = title or "Untitled"
end

function Test:setupTest()
    self.animationsStarted = false
end

function Test:startOrResetAnimations()
    if self.animationsStarted then
        self:resetAnimations()
    else
        self:startAnimations()
    end
end

function Test:startAnimations()
    self.animationsStarted = true
end

function Test:resetAnimations()
    self.animationsStarted = false
    tween.resetAll()
end

function Test:drawTest()
    pushMatrix()
    pushStyle()

    background(40, 40, 50)

    font("Arial")
    strokeWidth(5)
    fill(210, 219, 224, 255)
    fontSize(38)

    textAlign(CENTER)
    text(self.name, WIDTH/2, HEIGHT - 100)

    self:draw()

    popStyle()
    popMatrix()
end

function Test:cleanup()
    output.clear()
end

