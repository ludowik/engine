App('Horloge')

app = Horloge

function Horloge:init(lieu, decalage, x, y, rayon)
    Application.init(self)
    
    self.lieu = lieu or 'Garches'
    
    self.decalage = decalage or 0
    
    self.x = x or WIDTH/2
    self.y = y or HEIGHT/2
    
    self.rayon = rayon or 150
end

function Horloge:draw()
    background(51)
    
    if config.projectionMode == 'perspective' then
        ortho3d()
    else
        ortho()
    end
    
    self:graduation(self.x, self.y, self.rayon, 15,  4, 5, false, red)
    self:graduation(self.x, self.y, self.rayon,  8, 12, 3, true , green)
    self:graduation(self.x, self.y, self.rayon,  4, 60, 1, false, blue)
    
    local date = date()
    local ipart, fpart = math.modf(os.clock())

    self:aiguille(red  , self.x, self.y, ( date.hour - self.decalage ) * 30 , self.rayon * 0.8, 3)
    self:aiguille(green, self.x, self.y, ( date.min                  ) * 6  , self.rayon * 0.8, 2)
    self:aiguille(blue , self.x, self.y, ( date.sec                  ) * 6  , self.rayon * 0.8, 1)
    
    width, height = textSize(self.lieu)
    
    textMode(CENTER)
    text(self.lieu, self.x, self.y - self.rayon - height)
end

function Horloge:aiguille(clr, x, y, a, l, size)
    pushMatrix()
    
    translate(x, y)
    rotate(-a, 0, 0, 1)
    
    local m = mesh()
    m.vertices = {
        vec2(-size, 0),
        vec2(size, 0),
        vec2(0, l)
    }

    noStroke()
    fill(clr)
        
    m:draw()
    
    popMatrix()
end

-- This function draws a circle graduation
function Horloge:graduation(x, y, r, l, p, size, draw_text, c)
    local r0 = r - l * 2
    local r1 = r - l / 2
    local r2 = r + l / 2
    
    strokeWidth(size)
    stroke(c)
    
    draw_text = draw_text or false
    c = c or white

    local a = 90
    local da = -360 / p
    
    for i = 1, p do
        a = a + da
        
        local cos_r = cos(rad(a))
        local sin_r = sin(rad(a))
        
        line(
            x + cos_r * r1, y + sin_r * r1,
            x + cos_r * r2, y + sin_r * r2
        )
        
        if draw_text then
            textMode(CENTER)
            text(i,
                x + cos_r * r0,
                y + sin_r * r0
            )
        end
    end
end
