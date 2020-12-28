GRID_MARGE = 5
CELL_MARGE = 2

GRID_SIZE = min(WIDTH, HEIGHT)

CELL_SIZE = floor((GRID_SIZE - GRID_MARGE * 2) / (GRID_SIZE == WIDTH and 7 or 9))

BALL_SIZE = floor(CELL_SIZE / 6)

AREA_WIDTH  = CELL_SIZE * 7
AREA_HEIGHT = CELL_SIZE * 9

function setup()
    supportedOrientations(PORTRAIT)

    physics = Physics2d(0, 0)
    physics:setArea(0, 0, AREA_WIDTH, AREA_HEIGHT)

    areaPosition = vector(
        (WIDTH - AREA_WIDTH) / 2,
        (HEIGHT - AREA_HEIGHT) / 2)

    level = 1

    emitter = Table()
    emitterCart = Table()

    balls = Table()

    ballsToAdd = 0

    bonuses = Table()
    boxes = Table()

    loadGame()

    app.scene:add(balls, boxes, bonuses, physics)

    parameter.watch('#emitter')
    parameter.watch('#emitterCart')
end

function checkCell(items, i, j)
    local done = true
    for _,item in ipairs(items) do
        if i == item.cell.x and j == item.cell.y then
            done = false
            break
        end
    end
    return done
end

function addBoxes()
    local items = boxes + bonuses
    for _,item in ipairs(items) do
        item:nextLine()
    end

    physics:updatePosition(items)

    local j = 8
    for i=1,7 do
        local free = checkCell(items, i, j)

        local box
        if free then            
            if random() > 0.9 then
                box = addBox(CIRCLE, i, j)
                items:add(box)                

            elseif random() > 0.9 then
                box = addBox(POLYGON, i, j)
                items:add(box)                

            elseif random() > 0.5 then
                box = addBox(RECT, i, j)
                items:add(box)                
            end
        end
    end

    repeat
        local i = randomInt(1,7)
        local j = randomInt(4,9)

        local free = checkCell(items, i, j)

        if free then
            addBonus(i, j)
            break
        end
    until false
end

function addBox(itemType, i, j)
    local box
    if itemType == CIRCLE then
        box = Box(level, i, j, itemType)
        physics:addItem(box, STATIC, CIRCLE)

        boxes:add(box)

    elseif itemType == POLYGON then
        box = Box(level, i, j, itemType)
        local w, h = box.size.x, box.size.y

        local triangle = randomInt(1, 4)
        local triangles = {
            {-w/2, -h/2, w/2, -h/2, -w/2, h/2},
            {-w/2, -h/2, w/2,  h/2, -w/2, h/2},
            {-w/2, -h/2, w/2, -h/2,  w/2, h/2},
            { w/2, -h/2, w/2,  h/2, -w/2, h/2}
        } 

        physics:addItem(box, STATIC, POLYGON,
            nil, nil, nil,
            triangles[triangle])

        boxes:add(box)

    elseif itemType == RECT then
        box = Box(level, i, j, itemType)
        physics:addItem(box, STATIC, RECT)

        boxes:add(box)
    end

    return  box
end

function addBall()
    local ball = Ball(BALL_SIZE)
    physics:addItem(ball, DYNAMIC, 'circle', -1)

    balls:add(ball)

    ball.linearVelocity = vector()

    pushBall(emitter, ball)
end

function pushBall(emitter, ball)
    if #emitter == 0 then
        emitter.position = vector(ball.position.x, ball.position.y)
    else
        ball.position = vector(emitter.position.x, emitter.position.y)
        ball.needUpdatePosition = true
    end
    emitter:add(ball)
end

function addBonus(i, j)
    local bonus = Bonus(i, j)
    physics:addItem(bonus, DYNAMIC, CIRCLE)

    bonuses:add(bonus)            
end

function nextLevel()
    level = level + 1

    addBoxes()

    emitter, emitterCart = emitterCart, emitter

    for _=1,ballsToAdd do
        addBall()
    end
    ballsToAdd = 0

    update = pop('update')

    saveGame()
end

function loadGame()
    boxes = Table()

    local info = table.load(getProjectDataPath('game'))
    if info then
        for i,v in ipairs(info.boxes) do
            local box = addBox(v.itemType or RECT, v.cell.x, v.cell.y)
            box.collision = v.collision
        end

        for i,v in ipairs(info.balls) do
            addBall()
        end
        level = #info.balls

        for i,v in ipairs(info.bonuses) do
            addBonus(v.cell.x, v.cell.y)
        end

    else
        addBoxes()
        addBall()

        saveGame()

    end
end

function saveGame()
    local info = {
        boxes = boxes,
        balls = balls,
        bonuses = bonuses
    }
    table.save(info, getProjectDataPath('game'))
end

function update(dt)
    physics:processForce(balls)    
    physics:update(dt)

    if #emitter > 0 and emitter.linearVelocity then
        if emitter.delay == nil or emitter.delay <=0 then
            local ball = emitter:remove(#emitter)
            ball.linearVelocity = emitter.linearVelocity

            emitter.delay = 0.1

            if #emitter == 0 then
                emitter.linearVelocity = nil
            end

        else
            emitter.delay = emitter.delay - dt
        end
    end
end

function draw()
    background(51)

    translate(areaPosition.x, areaPosition.y)

    noFill()
    rectMode(CORNER)
    rect(0, 0, AREA_WIDTH, AREA_HEIGHT)

    app.scene:draw()

    if linearVelocity then
        line(emitter.position.x, emitter.position.y,
            emitter.position.x + linearVelocity.x,
            emitter.position.y + linearVelocity.y)
    end
end

function touched(touch)
    local position = emitter.position
    local direction = vector(CurrentTouch.x, CurrentTouch.y) - areaPosition
    linearVelocity = (direction - position):normalize() * AREA_HEIGHT

    if touch.state == ENDED then
        if #emitter > 0 then
            for i,ball in ipairs(balls) do
                emitter.linearVelocity = linearVelocity
            end
        end
        linearVelocity = nil
    end
end

function collide(contact)
    if contact.state == BEGAN then
        local edge, ball, box, bonus = contact:get('edge', 'ball', 'box', 'bonus')
        if edge and ball and edge.name == 'down' then
            ball.linearVelocity = vector()

            pushBall(emitterCart, ball)

            if #emitterCart == #balls then
                push('update', update)
                update = nextLevel
            end

        elseif box and ball then
            box.collision = box.collision - 1
            if box.collision <= 0 then
                boxes:removeItem(box)
                physics:removeItem(box)
            end

        elseif bonus and ball then
            if bonuses:findItem(bonus) then
                ballsToAdd = ballsToAdd + 1

                bonuses:removeItem(bonus)
                physics:removeItem(bonus)
            end
        end
    end
end
