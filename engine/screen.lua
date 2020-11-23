class 'Screen'

function Screen:init()
    local W, H
    if osx then
        W = W or 1480
        H = H or self:w2h(W)

        self.ratio = 1

    elseif windows then
        W = W or 1480
        H = H or self:w2h(W)

        self.ratio = 0.25

    elseif ios then
        if love then
            screen.w, screen.h = love.window.getMode()
        else
            H = 1024
            W = self:w2h(W)
        end

        self.ratio = 1
    end

    self.W = W
    self.H = H

    self.MARGE_X = 50
    self.MARGE_Y = 10

    if ios then
        self.W = self.w - 2 * self.MARGE_X
        self.H = self.h - 2 * self.MARGE_Y

    else
        self.w = 2 * self.MARGE_X + self.W * self.ratio
        self.h = 2 * self.MARGE_Y + self.H * self.ratio
    end
end

function Screen:w2h(w)
    return math.floor(w * 9 / 16)
end

function Screen:resize(w, h)
    screen.w, screen.h = w, h

    if screen.w > screen.h then
        screen.W, screen.H = max(screen.W, screen.H), min(screen.W, screen.H)
        screen.MARGE_X, screen.MARGE_Y = max(screen.MARGE_X, screen.MARGE_Y), min(screen.MARGE_X, screen.MARGE_Y)
        if osx then
            screen.ratio = 1
        else
            screen.ratio = 0.75
        end
    else
        screen.W, screen.H = min(screen.W, screen.H), max(screen.W, screen.H)
        screen.MARGE_X, screen.MARGE_Y = min(screen.MARGE_X, screen.MARGE_Y), max(screen.MARGE_X, screen.MARGE_Y)
        screen.ratio = 0.4
    end
    
    screen.w = 2 * screen.MARGE_X + screen.W * screen.ratio
    screen.h = 2 * screen.MARGE_Y + screen.H * screen.ratio
end
