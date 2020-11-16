-------------------------
-- Main game functions --
-------------------------


-- Use this function to perform your initial setup
function setup()
    supportedOrientations(PORTRAIT_ANY)

    bg = mesh()
    bat = nil
    ball = nil
    blocks = {}
    emitter = nil
    score = 0
    lives = 3
    ballIsMoving = false
    lastDelta = 0
    gameover = false
    won = false
    level = 1
    maxlevel = table.maxn(levels)

    -- Hide the sidebar in portrait mode
    displayMode(FULLSCREEN)

    ball = Ball()
    ball.vel.x = math.random(-3,3)
    bat = Bat()
    makeBG()
    makeBlocks()
    makeEmitter()
    print("Tap the bat to launch the ball.")
    print("Drag om the screen to move the paddle.")
    print("When the game is over tap the screen to restart.")
end

-- Make background mesh
function makeBG()
    bg:addRect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)

    local light = color(42, 47, 56, 255)
    local dark = color(22, 23, 25, 255)

    bg:color( 1, light )
    bg:color( 2, dark )
    bg:color( 3, dark )
    bg:color( 4, light )
    bg:color( 5, dark )
    bg:color( 6, light )
end

-- Make a particle emitter for effects
function makeEmitter()
    emitter = Emitter( {
            tex = "Cargo Bot:Star",
            startColor = color(255,255,255,255),
            endColor = color(255,255,0,0),
            minSize = 4,
            maxSize = 8,
            minSpeed = 100,
            maxSpeed = 150,
            accel = vec2(0,-700),
            rAccel = vec2(500,500),
            streak = false
            } )
end

-- create table of blocks from level array
function makeBlocks()
    for i = 1, 6 do
        c = getColourForRow(i)
        for j = 1, 10 do
            if levels[level][i][j] > 0 then
                table.insert(blocks, Block(30 + (j * 62), HEIGHT - (i * 32 + 35), c))
            end
        end
    end
end

-- get colour for current row
function getColourForRow(row)
    colChanger = row * 35
    if level % 4 == 1 then
        c = color(colChanger,0,255,255)
    elseif level % 4 == 2 then
        c = color(255,colChanger,0,255)
    elseif level % 4 == 3 then
        c = color(255,0,colChanger,255)
    else
        c = color(0,255,colChanger,255)
    end
    return c
end

-- Stop ball and put it back on bat
function resetBall()
    ballIsMoving = false
    ball.pos.x = bat.pos.x
    ball.pos.y = 41
end

-- Reset game to original state
function resetGame()
    score = 0
    lives = 3
    level = 1
    blocks = {}
    makeBlocks()
    gameover = false
    won = false
end

-- Level up
function nextLevel()
    score = score + 100 * lives * level
    --ball.vel.y = ball.vel.y + 0.5
    resetBall()
    if level < maxlevel then
        level = level + 1
        makeBlocks()
    else
        won = true
    end
end

-- Lose a life
function loseLife()
    resetBall()
    lives = lives - 1
    if lives == 0 then
        gameover = true
    end
end

-- This function gets called once every frame
function draw()
    background(0, 0, 0, 255)
    bg:draw()
    noSmooth()

    -- Update the ball
    if ballIsMoving then
        if ball:update() == false then
            loseLife()
        end
    else
        ball.pos.x = bat.pos.x
    end
    -- Check collision with the bat
    if bat:collide(ball) == false then
        -- Check collision with the blocks
        -- no need to do this if ball has hit bat.
        -- Still does a lot of unecessary checks
        for i = 1, table.maxn(blocks) do
            if blocks[i]:collide(ball) then

                -- Emit particles
                emitter:emit( blocks[i].pos, 10 )

                table.remove(blocks, i)
                score = score + 100
                if table.maxn(blocks) == 0 then
                    nextLevel()
                end
                break
            end
        end
    end

    -- Draw game objects
    bat:draw()
    ball:draw()
    for i = 1, table.maxn(blocks) do
        blocks[i]:draw()
    end

    -- Draw score and lives
    stroke(255, 255, 255, 255)
    strokeWidth(2)
    number(10, HEIGHT - 10, score, 10)
    number(WIDTH - 30, HEIGHT - 10, "x"..lives, 8)
    noStroke()
    fill(253, 255, 0, 255)
    ellipse(WIDTH - 50, HEIGHT - 19, 20)

    -- Draw win/lose screen
    if gameover then
        gameText("LOSE",350,400)
    elseif won then
        gameText("WIN",340,400)
    end

    emitter:draw()
end

function touched(touch)
    if CurrentTouch.state == BEGAN or CurrentTouch.state == MOVING then
        lastDelta = CurrentTouch.deltaX

        if gameover == false and won == false then
            -- If bat is touched launch ball
            if ballIsMoving == false then
                if CurrentTouch.x < bat:right() + 10 and
                CurrentTouch.x > bat:left() - 10 and
                CurrentTouch.y < bat:top() + 20 and
                CurrentTouch.y > bat:bottom() then
                    if ballIsMoving == false then
                        ballIsMoving = true
                    end
                end
            else
                -- Otherwise move the bat
                bat.pos.x = bat.pos.x + lastDelta

                -- Clamp the bat position
                bat.pos.x = math.min( bat.pos.x, WIDTH - bat.size.x/2 )
                bat.pos.x = math.max( bat.size.x/2, bat.pos.x )
            end
        elseif gameover == true or won == true then
            -- If centre of screen is touched restart game
            if CurrentTouch.tapCount == 1 then
                resetGame()
            end
        end
    end

    lastDelta = 0
end

-- Write game text
function gameText(str, x, y)
    pushStyle()
    textMode(CENTER)
    fill(255, 255, 255, 255)
    font("ArialRoundedMTBold")
    fontSize(48)
    text(str,x,y)
    popStyle()
end

