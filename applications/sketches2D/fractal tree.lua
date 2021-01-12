App('FractalTree')

function FractalTree:init()
    Application.init(self)

    parameter.number('lenBranch', 100, 500, 120)
    parameter.integer('levelBranch', 0, 10, 6)
    parameter.number('angleBranch', 0, 90, 45)
    parameter.number('ratioBranch', 0.2, 0.8, 0.63)
end

function FractalTree:draw()
    background(51)

    b = Branch(WIDTH/2, 150, lenBranch, 0)
    b:draw()
end

Branch = class('Branch')

function Branch:init(x, y, len, angle, level)
    level = (level or 0) + 1

    self.x = x
    self.y = y

    self.len = len

    self.angle = angle

    if level < levelBranch then
        self.branchA = Branch(0, len, len*ratioBranch,  angleBranch, level)
        self.branchB = Branch(0, len, len*ratioBranch, -angleBranch, level)
    end
end

function Branch:draw()
    pushMatrix()

    stroke(white)

    translate(self.x, self.y)
    rotate(self.angle)

    line(0, 0, 0, self.len)

    if self.branchA then
        self.branchA:draw()
        self.branchB:draw()
    end

    popMatrix()
end
