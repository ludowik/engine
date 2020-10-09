supportedOrientations(CurrentOrientation)

function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(FULLSCREEN)

    g = .0000981
    trackFunction, trackNormal, maxHeight = Tracks.loop(3,2)
    plank = mesh()
    local ver = {}
    local col = {}
    local track = TrackPoints({
            pathFunction = trackFunction,
            normalFunction = trackNormal,
            delta = .01,
            step = .3,
        })
    local u
    for k,v in ipairs(track) do
        u = Vec3.SO(v[2],v[3])
        AddPlank({
                origin = v[1],
                width = 1*u[3],
                height = .1*u[2],
                depth = .2*u[1],
                light = Vec3(1,2,3),
                colour = Colour.x11.Burlywood3,
                vertices = ver,
                colours = col
            })
    end
    plank.vertices = ver
    plank.colors = col
    size = .1
    stars = mesh()
    ver = {}
    col = {}
    for i=1,200 do
        AddStar({
                origin = Vec3(
                    40*(2*math.random()-1),
                    10*(2*math.random()-1),
                    40*(2*math.random()-1)
                ),
                size = .25,
                vertices = ver,
                colours = col,
                light = Vec3(1,2,3)
            })
        AddStar({
                origin = 100*Vec3.Random(),
                size = .25,
                vertices = ver,
                colours = col,
                light = Vec3(1,2,3)
            })
    end

    stars.vertices = ver
    stars.colors = col

    time = 0
    speed = .05
    ht = .5

    energy = speed^2 + 2*g*(maxHeight +5)
    nml = Vec3(1,0,0)
    dp = Vec3(0,0,1)
    azimuth = 0
    zenith = math.pi/2
    ca = 1
    sa = 0
    cz = 0
    sz = 1

    paused = nil
    ptext = "Tap to begin"
end

function draw()
    background(Colour.svg.Black)
    perspective(45,WIDTH/HEIGHT)
    if paused ~= nil then
        if not paused then
            time = time + speed*DeltaTime
        end

        local pos = trackFunction(time)
        local tmp
        tmp = tangent({delta = .1,
                pathFunction = trackFunction,
                time = time})
        if not tmp:is_zero() then
            dp = tmp
        end
        nml = trackNormal(time)

        speed = math.sqrt(energy - 2*g*pos.y)
        local ob = Vec3.SO(dp,nml)

        pos = pos + ht*ob[2]

        local dir = pos + size*(sz*(ca*ob[1] + sa*ob[3]) + cz*ob[2])
        camera(pos.x,pos.y,pos.z,
            dir.x,dir.y,dir.z,
            ob[2].x,ob[2].y,ob[2].z)
    else
        camera(0,8*maxHeight,15,0,0,0,0,1,0)
    end
    plank:draw()
    stars:draw()

    if paused == nil or paused then
        resetMatrix()
        ortho()
        viewMatrix(matrix())
        font("Copperplate-Bold")
        fontSize(30)
        fill(Colour.svg.HotPink)
        text(ptext,WIDTH/2,HEIGHT/2)
    end

end

function touched(touch)
    if paused == nil or paused then
        paused = false
        return
    end
    if touch.state == ENDED and touch.tapCount == 2 then
        paused = true
        ptext = "Tap to resume"
        return
    end
    azimuth = azimuth - touch.deltaX/WIDTH*math.pi
    zenith = zenith - touch.deltaY/HEIGHT*math.pi
    ca = math.cos(azimuth)
    sa = math.sin(azimuth)
    cz = math.cos(zenith)
    sz = math.sin(zenith)
end

function AddPlank(t)
    local w = t.width
    local h = t.height
    local d = t.depth
    local o = t.origin
    local vertices = t.vertices or {}
    local colours = t.colours or {}
    local c = t.colour or Colour.x11.Burlywood3
    local n,m
    local tt = {}
    local l = t.light:normalise()
    local v = {
        w:normalise():dot(l),
        h:normalise():dot(l),
        d:normalise():dot(l)
    }
    local u
    for i=0,5 do
        n = math.floor(i/2)
        m = 2*(i%2) - 1
        for j=0,5 do
            tt = {m,2*(j%2)-1,2*(math.floor((j+1)/3)%2) - 1}
            u = o + tt[n+1]*w + tt[(n+1)%3+1]*h + tt[(n+2)%3+1]*d
            table.insert(vertices,u:tovec3())

            table.insert(colours,
                Colour.shade(c,75 + 25*m*v[n+1])
            )
        end
    end
    return vertices,colours
end

function TrackPoints(a)
    a = a or {}
    local pts = a.points or {}
    local t = a.start or 0
    local r = a.step or .1
    r = r*r
    local s = a.delta or .1
    local f = a.pathFunction or function(q) return q*Vec3(1,0,0) end
    local nf = a.normalFunction or function(q) return Vec3(0,1,0) end
    local b = a.finish or 1
    local tpt = f(t)
    table.insert(pts,{tpt,
            tangent({delta = s, pathFunction = f, time = t}),
            nf(t),t})
    local dis
    local p
    while t < b do
        dis = 0
        while dis < r do
            t = t + s
            p = f(t)
            dis = dis + p:distSqr(tpt)
            tpt = p
        end
        if t > b then
            t = b
            p = f(b)
        end
        table.insert(pts,{p,
                tangent({delta = s, pathFunction = f, time = t}),
                nf(t),t})
        tpt = p
    end
    return pts
end

function AddStar(t)
    local o = t.origin
    local s = t.size
    local l = t.light:normalise()/(math.sqrt(3))
    local vertices = t.vertices or {}
    local colours = t.colours or {}
    local b = Vec3.RandomBasis()
    local v,n,c
    local bb = {}
    for i=0,7 do
        bb[1] = 2*(i%2)-1
        bb[2] = 2*(math.floor(i/2)%2)-1
        bb[3] = 2*(math.floor(i/4)%2)-1
        v = bb[1]*b[1] + bb[2]*b[2] + bb[3]*b[3]
        n = math.abs(v:dot(l))

        c = Colour.shade(Colour.x11["LemonChiffon" .. math.random(1,4)], 70+n*30)
        for m=1,3 do
            table.insert(colours,c)
            table.insert(vertices,(o+s*(v - 2*bb[m]*b[m])):tovec3())
        end
    end
    return vertices,colours
end

function tangent(a)
    local s = a.delta/2 or .1
    local f = a.pathFunction or function(q) return q*Vec3(1,0,0) end
    local t = a.time or 0
    local u = f(t-s)
    local v = f(t+s)
    return (v-u)/(2*s)
end

Tracks = {}

function Tracks.torus(p,q)
    local innerRa = 10
    local innerRb = 10
    local outerR = 30
    local trackFunction = function(t)
        local it = p*t*2*math.pi
        local ot = q*t*2*math.pi
        return Vec3(
            (outerR + innerRb*math.cos(it))*math.cos(ot),
            innerRa*math.sin(it),
            (outerR + innerRb*math.cos(it))*math.sin(ot)
        )
    end
    local trackNormal = function(t)
        local it = p*t*2*math.pi
        local ot = q*t*2*math.pi
        return Vec3(
            innerRa*math.cos(it)*math.cos(ot),
            innerRb*math.sin(it),
            innerRa*math.cos(it)*math.sin(ot)
        )
    end
    local coreFunction = function(t)
        local ot = q*t*2*math.pi
        return Vec3(
            outerR*math.cos(ot),
            0,
            outerR*math.sin(ot)
        )
    end
    local maxHeight = innerRa
    return trackFunction, trackNormal, maxHeight
end

function Tracks.mobius()
    local r = 30
    local trackFunction = function(t)
        local a = 2*math.pi*t
        return Vec3(r*math.cos(a),0,r*math.sin(a))
    end
    local trackNormal = function(t)
        local a = math.pi*t
        return Vec3(
            math.sin(a)*math.cos(2*a),
            math.cos(a),
            math.sin(a)*math.sin(2*a))
    end
    return trackFunction,trackNormal,0
end

function Tracks.loop(p,q)
    local r = 30
    local h = 10
    local w = Vec3(0,30,0)
    local trackFunction = function(t)
        local a = 2*math.pi*t
        return Vec3(
            r*math.cos(a),
            h*math.sin(p*a),
            r*math.sin(q*a))
    end
    local trackNormal = function(t)
        return w - trackFunction(t)
    end
    return trackFunction,trackNormal,h
end



