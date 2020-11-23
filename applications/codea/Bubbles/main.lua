Bubbles = class()

function Bubbles:init(x, y)
    -- Initialising our bubble emitter
    self.x = x
    self.y = y
    self.bubbles = {}
    self.maxbubbles = 100
    self.bubblecount = 0
end

function Bubbles:emit()
    -- Make sure we don't emit more than maxbubbles
    if self.bubblecount < self.maxbubbles then
        local dir = vec2(0,1):rotateInPlace(math.random() - 0.5):mul(math.random(1,6))

        local size = math.random(10, 50)
        local life = math.random(30, 60)

        local bubble = {
            pos = vec2(self.x, self.y),
            dir = dir,
            size = size,
            life = life,
            clr = color.random()
        }

        -- Bubbles have the following properties
        --  dir: direction
        --  size: size of the bubble
        --  life: how many frames the bubble lives
        --  pos: the initial position of the bubble
        --  clr: the color of the bubble
        --   (all bubbles start at the emitter position)

        -- Add the bubble to our table of bubbles
        table.insert(self.bubbles, bubble)

        -- Keep track of how many bubbles we have
        self.bubblecount = self.bubblecount + 1
    end
end

-- This function updates all the bubbles in the system
function Bubbles:update()
    local dt = DeltaTime * 60
    -- Loop through bubbles
    for k,v in pairs(self.bubbles) do
        -- Add direction of bubble to its
        --  position, to generate new position
        v.pos:add(v.dir * dt)

        -- Subtract one from its life
        v.life = v.life - dt

        -- If this bubble's life is 0
        if v.life <= 0 then
            -- Remove it from the table
            self.bubbles[k] = nil

            -- Reduce our bubble count
            --  (we can emit more now!)
            self.bubblecount = self.bubblecount - 1
        end
    end
end

-- This function draws all the bubbles in the system
function Bubbles:draw()
    -- Store current style
    pushStyle()

    -- Set up our bubble style
    ellipseMode(CENTER)
    
    stroke(255)
    strokeWidth(4)
    
    -- Loop through bubbles and draw them
    for k,v in pairs(self.bubbles) do
        fill(v.clr)
        circle(v.pos.x, v.pos.y, v.size/2)
    end

    -- Restore original style
    popStyle()
end

-- Use this function to perform your initial setup
function setup()

    displayMode(OVERLAY)

    -- Create a global bubble emitter
    emitter = Bubbles(0, 0)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color
    background(40, 40, 50)

    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    fill(255)
    text("Drag your finger to make bubbles", WIDTH/1.5, HEIGHT - 40)

    -- Update and draw bubbles
    emitter:update()
    emitter:draw()
end

-- This function gets called whenever a touch event occurs
function touched(touch)
    -- Whenever the screen encounters a touch event we:
    --  update the emitter position
    --  emit a single bubble
    emitter.x = touch.x
    emitter.y = touch.y
    emitter:emit()

    -- Touch events happen when your finger moves, begins
    --  touching or ends touching
end