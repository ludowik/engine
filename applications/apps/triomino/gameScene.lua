class('GameScene', UIScene)

function GameScene:init()
    UIScene.init(self)

    self.bgColor = color(52)
    
    self.touch = Table()

    self.layoutProc = Layout.column
    self.alignment = 'v-center,h-center'

    self.marge = 0

    self.score = 6000
    self:add(Label('score'):bind(self, 'score'))	

    self.grid = TrioGrid(10)

    self:add(UIScene()
        :attribs{alignment = 'h-center'}
        :add(self.grid))

    self.minos = UIScene(Layout.row)
    for i=1,3 do
        self.minos:add(UIScene()
            --:attribs{alignment = 'center'}
            :setGridSize(2, 2))
    end
    self:resetMinos()

    self:add(UIScene()
        :attribs{alignment = 'center'}
        :add(UIScene(Layout.column)
            :add(self.minos,
                Button('new', function ()
                        self:resetMinos()
                    end))))

    self:add(Button('reset', function ()
                self.grid:reset()
            end))

    self:load()
end

function GameScene:save()
    saveProjectData('score', self.score)
    saveProjectData('bestScore', self.bestScore)

    self.grid:save()
end

function GameScene:load()
    self.score = readProjectData('score', 0)
    self.bestScore = readProjectData('bestScore', 0)

    self.grid:load()
end

function GameScene:resetMinos()
    for i,m in ipairs(self.minos.nodes) do
        m:remove(1)
        m:add(createMino())
    end
end

function GameScene:getMino(id)
    return self.minos:get(self.touch[id]):get(1), self.minos:get(self.touch[id])
end

function GameScene:setMino(id, mino)
    id = self.touch[id]

    self.minos[id]:remove(1)
    self.minos[id]:add(mino)
end

function GameScene:touched(touch)
    onTouch = {
        [BEGAN] = GameScene.touchedBegan,
        [MOVING] = GameScene.touchedMoving,
        [ENDED] = GameScene.touchedEnded,
        [CANCELLED] = GameScene.touchedCancelled
    }

    onTouch[touch.state](self, touch)
end

function GameScene:touchedBegan(touch)
    if self.grid.tweenId then
        tween.reset(self.grid.tweenId)
        self.grid.tweenId = nil
    end
    if self.touch:getnKeys() > 0 then return false end

    for i,mino in ipairs(self.minos.nodes) do
        if mino:contains(touch) then
            self.touch[touch.id] = i
            return
        end
    end

    return false
end

function GameScene:touchedMoving(touch)
    if self.touch[touch.id] then
        self.grid:unselect()

        local mino, uiMino = self:getMino(touch.id)
        if touch.prevState == BEGAN then
            mino.translation = mino.translation + vec3(0, mino.size.y/2)
        end

        mino.translation = mino.translation + vec3(touch.deltaX, -touch.deltaY)
        mino.scaling = vec3(1, 1)

        print(mino.translation + mino.parent.absolutePosition)

        local pos = self.grid:inGrid(mino)

        if pos then
            if self.grid:isSelectable(pos, mino) then
                self.grid:select(pos, mino)
            end
        end
    end
end

function GameScene:touchedEnded(touch)
    if self.touch[touch.id] then
        self.grid:unselect()

        local mino = self:getMino(touch.id)
        mino.translation = mino.translation + vec3(touch.deltaX, -touch.deltaY)

        local pos = self.grid:inGrid(mino)
        if pos and self.grid:isSelectable(pos, mino) then
            self.grid:add(pos, mino)
            self.score = self.score + self.grid:check()
            self:save()

            self:setMino(touch.id, createMino())

            self:getMino(touch.id).position = mino.position
        else
            tween(0.2, mino, {translation = vec3()}, tween.easing.linear)
            self:animateMino(mino)
        end

        if self:test() == false then
            self.bestScore = math.max(self.bestScore, self.score)
            app:pushScene(GameOver())
        end
    end

    self.touch[touch.id] = nil
end

function GameScene:touched(touch)    
    if self.touch[touch.id] then
        local i = self.touch[touch.id]
        local mino = self.minos:get(i):get(1)
        local clockwise = touch.x > mino.position.x
        tween(0.2, mino,
            {angle=clockwise and 90 or -90},
            tween.easing.linear,
            function ()
                local rotatedMino = mino:rotate(clockwise)
                self.minos[i]:remove(1)
                self.minos[i]:add(rotatedMino)
                self:animateMino(rotatedMino)
            end)
    end

    self.touch[touch.id] = nil
end

function GameScene:animateMino(mino)
    mino.scaling = defaultScale()
    self.grid.tweenId = tween(0.5, mino, {scaling = 2*(mino.scaling)}, {
            easing = tween.easing.linear,
            loop = tween.loop.pingpong
        })
end

function GameScene:test()
    for i=1,3 do
        local mino = self.minos:get(i):get(1)
        for n=1,4 do
            if self.grid:findSelectable(mino) then
                return true
            end
            mino = mino:rotate()
        end
    end
    return false
end
