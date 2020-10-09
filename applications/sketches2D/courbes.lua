function setup()
    poids = {
        84.4, 84.6, 84.2, 84.4, 84.6, 84.8, 84.2, 84.0, 84.0, 84.2, 84.2, 84.8, 84.8, 84.0, 83.8, 84.8, 84.0, 83.8,
        83.8, 84.2, 84.4, 84.2, 84.0, 83.8, 84.0, 83.9, 83.7, 84.0, 84.8, 84.2, 83.7, 83.6, 83.6, 83.5, 83.4, 84.0,
        83.2, 83.6, 83.6, 83.6, 83.6, 83.4, 83.4, 83.4, 83.0, 83.2, 83.4, 83.2, 83.6, 83.4, 82.8, 83.4, 83.4, 83.4,
        83.4, 83.0, 83.4, 83.0, 83.0, 82.8, 82.7, 82.6, 82.2, 82.6, 82.2, 82.8, 82.2, 82.2, 82.2, 82.2, 82.4, 82.4,
        82.2, 82.4, 82.6, 82.8, 82.2, 83.0, 82.2, 82.4, 82.2, 82.8, 82.0, 81.6, 81.7, 81.4, 81.4, 82.0, 82.2, 81.4,
        81.0, 80.6, 80.6, 81.2, 81.4, 82.0, 81.8, 81.2, 81.0, 80.2, 80.0, 80.0, 80.0, 80.0, 80.4
    }
end

function update(dt)
end

function draw()
    background()

    x = 0

    translate(x, H/2)

    scale(1, 100)

    translate(0, -80)

    beginShape()
    for i,v in ipairs(poids) do
        vertex(x, v)
        x = x + 10
    end
    endShape()
end
