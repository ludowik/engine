-- TODO : light sur les primitives 3D

App('appPrimitives')

function appPrimitives:init()
    Application.init(self)

    supportedOrientations(LANDSCAPE_ANY)

    self.primitiveWidth = 100
    self.primitiveHeight = 120
    
    self.angle = 0

    self.w = self.primitiveWidth * #primitives
    self.h = self.primitiveHeight * #styles

    self.x = (W - self.w) / 2
    self.y = (H - self.h) / 2

    self.vectors = Model.random.polygon(self.primitiveWidth/2)

    self.mesh = mesh(Model.triangulate(self.vectors))
    self.mesh.shader = Shader('polygon')

    parameter.number('use_strokeWidth', 0, 50, 20)
end

function appPrimitives:update(dt)
    self.angle = self.angle + TAU / 4 * dt
end

function appPrimitives:draw()
    background(51)

    if config.projectionMode == 'perspective' then
        ortho3D(self.w, self.h)
    else
        translate(self.x, self.y)
        app.scene.camera = nil
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
                    fontSize(14)
                    textMode(CENTER)
                    text(infos or '', 0, 0)
                end
                popStyle()
            end,
            0,
            infos, w, h)

        for _,primitive in ipairs(primitives) do
            drawPrimitive(self, primitive, self.transformIndex, w/2, h/2)
        end

        x = 0
        y = y + self.primitiveHeight

        popStyle()
    end
end

styles = {
    function (self)
        stroke(white)
        strokeWidth(use_strokeWidth)
        noFill()
        self.transformIndex = 1
        return 'stroke(white, '..(use_strokeWidth)..')\nnofill\nrotate'
    end,

    function (self)
        stroke(white)
        strokeWidth(use_strokeWidth/2)
        fill(red)
        tint(red)
        self.transformIndex = 1
        return 'stroke(white, '..(use_strokeWidth/2)..')\nfill(red)\nrotate'
    end,

    function (self)
        noStroke()
        fill(blue)
        tint(blue)
        self.transformIndex = 1
        return 'nostroke\nfill(blue)\nrotate'
    end,

    function (self)
        stroke(green)
        strokeWidth(use_strokeWidth/2)
        fill(blue)
        tint(blue)
        self.transformIndex = 2
        return 'stroke(green, '..(use_strokeWidth/2)..')\nfill(blue)\nscale'
    end,

    function (self)
        local c = map(cos(self.angle), -1, 1, 0, 1)
        local s = map(sin(self.angle), -1, 1, 0, 1)
        stroke(color(s))
        strokeWidth(use_strokeWidth/2)
        fill(color(c))
        tint(color(c))
        self.transformIndex = 0
        return 'stroke(gray, '..(use_strokeWidth/2)..')\nfill(gray)\ncolor'
    end
}

transforms = {
    function (self)
        rotate(deg(self.angle))
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
        circle(0, 0, w/2)
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
        text('lca', 0, 0)
    end,

    function (self, w, h)
        plane(w, h)
    end,

    function (self, w, h)
        light(true)
        box(w)
    end,

    function (self, w, h)
        sphere(w)
    end,

    function (self, w, h)
        pyramid(w)
    end
}
