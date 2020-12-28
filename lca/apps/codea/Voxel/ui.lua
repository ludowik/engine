--# Ui
Ui = class()

function Ui:init()
    self.smallBtn = rRect(30,30,10)
    self.largeBtn = rRect(100,30,10)
    self.tools = {"Add","Delete","Re-Col","Re-Tex"}
    self.texImg = {}
    local texW,texH = TEXTURE.width,TEXTURE.height
    for k,v in ipairs(TEXRANGE) do
        local w,h = texW*(v[2].x-v[1].x),texH*(v[2].y-v[1].y)
        local img = image(w,h)
        setContext(img)
        sprite(TEXTURE,(texW/2)-(texW*v[1].x),(texH/2)-(texH*v[1].y))
        setContext()
        table.insert(self.texImg,img)
    end
end

function Ui:draw()
    noStroke()
    fill(59, 59, 59, 255)
    rect(-1,HEIGHT-40,WIDTH+1,41)
    pushMatrix()
    for k,v in ipairs(self.tools) do
        if mode == v then
            tint(47, 47, 47, 255)
        else
            tint(96, 96, 96, 255)
        end
        translate(105,0)
        sprite(self.largeBtn,0,HEIGHT-20)
        fill(214, 214, 214, 255)
        text(v,0,HEIGHT-20)
    end
    popMatrix()
    tint(127, 127, 127, 255)
    sprite(self.largeBtn,590,HEIGHT-20)
    tint(255, 255, 255, 255)
    sprite(self.texImg[TEXINDEX],590,HEIGHT-20,28,28)
    for k,v in ipairs(COLORS) do
        fill(v)
        local s
        if v == col then
            s = 30
        else
            s = 20
        end
        ellipse(k*35+685,HEIGHT-20,s)
    end
end

function Ui:touched(touch)
    if touch.state == ENDED then
        if touch.y > HEIGHT-40 then
            for i = 1,4 do
                local x = i * 110 - 50
                if touch.x > x and touch.x < x + 100 then
                    mode = self.tools[i]
                end
            end
            if touch.x > 540 and touch.x < 540 + 100 then
                if TEXINDEX == #TEXRANGE then
                    TEXINDEX = 1
                else
                    TEXINDEX = TEXINDEX + 1
                end
            end
            for k,v in ipairs(COLORS) do
                local x = k * 35 + 685 - 15
                if touch.x > x and touch.x < x + 30 then
                    col = v
                end
            end
        end
    end
end
