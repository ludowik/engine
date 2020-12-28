App('appPrimitives')

function appPrimitives:init()
    Application.init(self)
    
    supportedOrientations(LANDSCAPE_ANY)
    
    self.primitiveWidth = 60
    self.angle = 0

    self.w = #primitives * self.primitiveWidth
    self.h = #styles * self.primitiveWidth

    self.x = (WIDTH  - self.w) / 2
    self.y = (HEIGHT - self.h) / 2

    self.vectors = Model.random.polygon(self.primitiveWidth/2)
    self.mesh = mesh(Model.triangulate(self.vectors))
end

function appPrimitives:update(dt)
    self.angle = self.angle + tau/4*dt
end

function appPrimitives:draw()
    background(51)
    
    light(config.light)

    if config.projectionMode == 'perspective' then
        ortho3d(self.w, self.h)

    else
        translate(self.x, self.y)
        ortho()
    end

    local x, y = 0, 0
    local w, h = self.primitiveWidth, self.primitiveWidth

    local function drawPrimitive(self, primitive, transformIndex, ...)
        pushMatrix()
        do
            translate(x+w/2, y+h/2)

            if transformIndex > 0 and transformIndex <= #transforms then
                transforms[transformIndex](self)
            end

            primitive(self, ...)
        end
        popMatrix()

        x = x + w
    end

    for _,style in ipairs(styles) do
        pushStyle()

        local infos = style(self)
        drawPrimitive(self, function (self, infos, w, h)
                pushStyle()
                do
                    fill(white)
                    
                    fontSize(12)

                    textMode(CENTER)
                    text(infos or '', 0, 0)
                end
                popStyle()
            end,
            0,
            infos, w, h)

        for _,primitive in ipairs(primitives) do
            drawPrimitive(self, primitive, self.transformIndex, w, h)
        end

        x = 0
        y = y + h

        popStyle()
    end
end

styles = {
    function (self)
        stroke(white)
        strokeWidth(10)
        noFill()
        self.transformIndex = 1
        return 'stroke(white, 10)\nnofill\nrotate'
    end,
    function (self)
        stroke(white)
        strokeWidth(5)
        fill(red)
        self.transformIndex = 1
        return 'stroke(white, 5)\nfill(red)\nrotate'
    end,
    function (self)
        noStroke()
        fill(blue)
        self.transformIndex = 1
        return 'nostroke\nfill(blue)\nrotate'
    end,
    function (self)
        stroke(green)
        strokeWidth(5)
        fill(blue)
        self.transformIndex = 2
        return 'stroke(green, 5)\nfill(blue)\nscale'
    end,
    function (self)
        local c = map(cos(self.angle), -1, 1, 0, 1)
        local s = map(sin(self.angle), -1, 1, 0, 1)
        stroke(color(s))
        strokeWidth(5)
        fill(color(c))
        self.transformIndex = 0
        return 'stroke(gray, 5)\nfill(gray)\ncolor'
    end
}

transforms = {
    function (self)
        rotate(self.angle)
    end,
    function (self)
        scale(
            cos(self.angle),
            sin(self.angle))
    end
}

primitives = {
    function (self, w, h)
        point(0, 0)
    end,
    function (self, w, h)
        line(-w/2, -h/2, w/2, h/2)
    end,
    function (self, w, h)
        rectMode(CENTER)
        rect(0, 0, w, h)
    end,
    function (self, w, h)
        ellipseMode(CENTER)
        ellipse(0, 0, w, h/2)
    end,
    function (self, w, h)
        ellipseMode(CENTER)
        circle(0, 0, w)
    end,
    function (self, w, h)
        polygon(self.vectors)
    end,
    function (self, w, h)
        self.mesh:draw()
    end,
    function (self, w, h)
        sprite('documents:joconde', 0, 0, w, h)
    end,
    function (self, w, h)
        fontSize(32)
        textMode(CENTER)
        text('hello', 0, 0)
    end,
    function (self, w, h)
        plane(w, h)
    end,
    function (self, w, h)
        box(w)
    end,
    function (self, w, h)
        sphere(w)
    end,
    function (self, w, h)
        pyramid(w)
    end
}
