function setup()    
    parameter.link('CodingChallenges #30', 'https://thecodingtrain.com/CodingChallenges/030-phyllotaxis.html')
    
    parameter.integer('spacing', 2, 20, 4)
    parameter.number('theta', 130, 145, 137.5)

    local function setTheta(btn)
        theta = tonumber(btn.label)
    end
    
    parameter.action('137.3', setTheta)
    parameter.action('137.5', setTheta)
    parameter.action('137.7', setTheta)

    n = 0
end

local cos, sin, deg, rad, sqrt = math.cos, math.sin, math.deg, math.rad, math.sqrt

function draw()
    background(51)

    translate(W/2, H/2)
    rotate(n/10)

    local size = spacing - 1

    for i=0,n-1 do
        local radius = spacing * sqrt(i)

        local angle = i * rad(theta)

        local x = radius * cos(angle)
        local y = radius * sin(angle)

        strokeWidth(size*2)    
        stroke(hsl(((deg(angle)-radius)%360)*255/360, 255, 128))

        point(x, y)
    end

    n = n + 10
end
