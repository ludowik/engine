class 'Screen'

function Screen:init()
    local W, H
    if osx then
        W = W or 1480
        H = H or self:w2h(W)

    elseif windows then
        W = W or 1024
        H = H or self:w2h(W)

    elseif ios then
        if love then
            self.w, self.h = love.window.getMode()
        else
            H = 1024
            W = self:w2h(H)
        end
    end

    self.MARGE_X = 50
    self.MARGE_Y = 10 

    self.W = W
    self.H = H    

    self:resize(W, H) 
end

function Screen:w2h(w)
    return math.floor(w * 9 / 16)
end

function Screen:orientation()
    return self.W > self.H and LANDSCAPE or PORTRAIT
end

function Screen:resize(w, h)
    if w > h then
        self.W, self.H = max(self.W, self.H), min(self.W, self.H)
        self.MARGE_X, self.MARGE_Y = max(self.MARGE_X, self.MARGE_Y), min(self.MARGE_X, self.MARGE_Y)

        if osx then
            self.ratio = 1
        else
            self.ratio = 1
        end

    else
        self.W, self.H = min(self.W, self.H), max(self.W, self.H)
        self.MARGE_X, self.MARGE_Y = min(self.MARGE_X, self.MARGE_Y), max(self.MARGE_X, self.MARGE_Y)

        if osx then
            self.ratio = 0.65
        else
            self.ratio = 0.75
        end
    end

    if ios and love then
        self.W = self.w - 2 * self.MARGE_X
        self.H = self.h - 2 * self.MARGE_Y

    else
        self.w = 2 * self.MARGE_X + self.W * self.ratio
        self.h = 2 * self.MARGE_Y + self.H * self.ratio
    end

    self:pushSize()
end

function Screen:pushSize()
    if _G.env then
        _G.env.W = self.W
        _G.env.H = self.H

        _G.env.WIDTH  = self.W
        _G.env.HEIGHT = self.H
    end
end
