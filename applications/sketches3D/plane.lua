--# Main


function setup()
    --plane setup
    local p=MakePlane() --make mesh
    plane=QC(p) --create quaternion, pass it the mesh
    --joysticks
    joyPR=JoyStick() --pitch/roll
    joyY=JoyStick({centre=vec2(310,110)}) --yaw
    --plane postion and sky
    pos=vec3(0,0,0)
    sky=Sky(5000,readImage("Dropbox:SkyGlobe"))
    speed=2
    --camera settings
    --1 = directly behind, 2 = behind and above, 3 = POV cockpit view
    parameter.integer("Camera",1,3,1)
    camSettings={{vec3(0,0,30),false},{vec3(2,5,25),false},{vec3(0,1.5,-6.75),true}} --three camera positions
end

function draw()
    background(120)
    perspective()
    local jPR=joyPR:update() --get joystick movement
    local jY=joyY:update()
    --if joystick used, rotate plane, else level it 
    if joyPR:isTouched() or joyY:isTouched() then
        --convert joystick values to x,y,z rotations (how you do this is up to you)
        plane:AdjustOrientation(jPR.y,-jY.x,-jPR.x/3) 
    else 
        plane:RollLevel() 
    end
    local p=plane:Move(vec3(0,0,-speed)) --velocity vector
    pos=pos+p*DeltaTime --calculate new position
    plane:SetCamera(pos,camSettings[Camera][1],camSettings[Camera][2])
    sky:draw(pos)
    plane:draw(pos)
    joyPR:draw()
    joyY:draw()
end

function touched(t)
    joyPR:touched(t) --get joystick touches
    joyY:touched(t)
end





--# Utility
--Utility
 
--Sky utility

--this class creates and draws a sphere that surrounds the camera
--make the radius big enough to include the whole scene
--if the image is covering the entire sphere (top to bottom) its width should be twice its height
--if the image is covering the top half of the sphere, its width should be 4x its height
--in the case of this demo, the image is just for the top half, but it happens to look like sea 
--  if you paste it again on the bottom half. That's why if you provide an image whose width is 4x
--  its height, the code pastes it twice. You can delete that code if you don't want it

Sky=class()
function Sky:init(r,tex) --r=radius, tex=texture image
    --this code pastes the image twice - see note above
    if tex.width==tex.height*4 then
        local img=image(tex.width,tex.width/2)
        setContext(img)
        sprite(tex,img.width/2,img.height*3/4)
        sprite(tex,img.width/2,img.height*1/4,tex.width,tex.height)
        setContext()
        self.sky=CreateSphere(r,img)
    else
        self.sky=CreateSphere(r,tex)
    end --just use this if you only want to paste the image once
end

--draws the image, centred on vec3 p
function Sky:draw(p)
    pushMatrix()
    translate(p:unpack())
    self.sky:draw()
    popMatrix()
end

--these three functions create a sphere mesh
function CreateSphere(r,tex,col,nx,ny)
    local vertices,tc = Sphere_OptimMesh(nx or 40,ny or 20)
    vertices = Sphere_WarpVertices(vertices)
    for i=1,#vertices do vertices[i]=vertices[i]*r end
    local ms = mesh()
    ms.vertices=vertices
    if tex then ms.texture,ms.texCoords=tex,tc end
    ms:setColors(col or color(255))
    return ms
end

function Sphere_OptimMesh(nx,ny)
    local v,t={},{}
    local k,s,x,y,x1,x2,i1,i2,sx,sy=0,1,0,0,{},{},0,0,nx/ny,1/ny
    local c = vec3(1,0.5,0)
    local m1,m2
    for y=0,ny-1 do
        local nx1 = math.floor( nx * math.abs(math.cos(( y*sy-0.5)*2 * math.pi/2)) )
        if nx1<6 then nx1=6 end
        local nx2 = math.floor( nx * math.abs(math.cos(((y+1)*sy-0.5)*2 * math.pi/2)) ) 
        if nx2<6 then nx2=6 end
        x1,x2 = {},{}
        for i1 = 1,nx1 do x1[i1] = (i1-1)/(nx1-1)*sx end  x1[nx1+1] = x1[nx1]
        for i2 = 1,nx2 do x2[i2] = (i2-1)/(nx2-1)*sx end  x2[nx2+1] = x2[nx2]
        local i1,i2,n,nMax,continue=1,1,0,0,true
        nMax = nx*2+1
        while continue do
            m1,m2=(x1[i1]+x1[i1+1])/2,(x2[i2]+x2[i2+1])/2
            if m1<=m2 then 
                v[k+1],v[k+2],v[k+3]=vec3(x1[i1],sy*y,1)-c,vec3(x1[i1+1],sy*y,1)-c,vec3(x2[i2],sy*(y+1),1)-c
                t[k+1],t[k+2],t[k+3]=vec2(-x1[i1]/2,sy*y) ,vec2(-x1[i1+1]/2,sy*y),vec2(-x2[i2]/2,sy*(y+1))
                if i1<nx1 then i1 = i1 +1 end
            else
                v[k+1],v[k+2],v[k+3]=vec3(x1[i1],sy*y,1)-c,vec3(x2[i2],sy*(y+1),1)-c,vec3(x2[i2+1],sy*(y+1),1)-c
                t[k+1],t[k+2],t[k+3]=vec2(-x1[i1]/2,sy*y),vec2(-x2[i2]/2,sy*(y+1)),vec2(-x2[i2+1]/2,sy*(y+1))
                if i2<nx2 then i2 = i2 +1 end
            end        
            if i1==nx1 and i2==nx2 then continue=false end
            k,n=k+3,n+1
            if n>nMax then continue=false  end
        end
    end   
    return v,t
end

function Sphere_WarpVertices(verts)
    local m = matrix(0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0)
    local vx,vy,vz,vm        
    for i,v in ipairs(verts) do
        vx,vy = v[1], v[2]
        vm = m:rotate(180*vy,1,0,0):rotate(180*vx,0,1,0)
        vx,vy,vz = vm[1],vm[5],vm[9]
        verts[i] = vec3(vx,vy,vz)
    end    
    return verts
end  

-- *** Code to create blovk plane ***----

--first the block
function CreateBlock(w,h,d,col,pos,tex) --width,height,depth,colour,position,texture
    local x,X,y,Y,z,Z=pos.x-w/2,pos.x+w/2,pos.y-h/2,pos.y+h/2,pos.z-d/2,pos.z+d/2
    local v={vec3(x,y,Z),vec3(X,y,Z),vec3(X,Y,Z),vec3(x,Y,Z),vec3(x,y,z),vec3(X,y,z),vec3(X,Y,z),vec3(x,Y,z)}
    local vert={v[1],v[2],v[3],v[1],v[3],v[4],v[2],v[6],v[7],v[2],v[7],v[3],v[6],v[5],v[8],v[6],v[8],v[7],
                v[5],v[1],v[4],v[5],v[4],v[8],v[4],v[3],v[7],v[4],v[7],v[8],v[5],v[6],v[2],v[5],v[2],v[1]}
    local texCoords
    if tex then    
        local t={vec2(0,0),vec2(1,0),vec2(0,1),vec2(1,1)}            
        texCoords={t[1],t[2],t[4],t[1],t[4],t[3],t[1],t[2],t[4],t[1],t[4],t[3],t[1],t[2],t[4],t[1],t[4],t[3],
                   t[1],t[2],t[4],t[1],t[4],t[3],t[1],t[2],t[4],t[1],t[4],t[3],t[1],t[2],t[4],t[1],t[4],t[3]}
    end
    local n={vec3(0,0,1),vec3(1,0,0),vec3(0,0,-1),vec3(-1,0,0),vec3(1,0,0),vec3(-1,0,0)}
    local norm={}
    for i=1,6 do for j=1,6 do norm[#norm+1]=n[i] end end
    local ms = mesh()
    ms.vertices = vert
    ms.normals=norm
    if tex then ms.texture,ms.texCoords = tex,texCoords end
    ms:setColors(col or color(255))
    return ms
end  

--and then the plane
function MakePlane()
    local img=readImage("Platformer Art:Block Brick"):copy(4,4,62,62)
    local b=CreateBlock(1,1,1,color(255),vec3(0,0,0),img)
    local bv,bt=b:buffer("position"),b:buffer("texCoord")
    local m=mesh()
    local v,t={},{}
    local w,h,d=1.5,1.5,15 --body
    for i=1,b.size do v[#v+1]=vec3(bv[i].x*w,bv[i].y*h,bv[i].z*d) end for i=1,b.size do t[#t+1]=bt[i] end
    local w,h,d=1.5,0.5,2 --cockpit
    for i=1,b.size do v[#v+1]=vec3(bv[i].x*w,bv[i].y*h+1.25,bv[i].z*d-4) end for i=1,b.size do t[#t+1]=bt[i] end
    local w,h,d=16,0.25,3  --wings
    for i=1,b.size do v[#v+1]=vec3(bv[i].x*w,bv[i].y*h+0.5,bv[i].z*d-3) end for i=1,b.size do t[#t+1]=bt[i] end
    local w,h,d=8,0.25,1.5 --tail horizontal
    for i=1,b.size do v[#v+1]=vec3(bv[i].x*w,bv[i].y*h+0.5,bv[i].z*d+7) end for i=1,b.size do t[#t+1]=bt[i] end
    local w,h,d=0.25,3,2 --tail vertical
    for i=1,b.size do v[#v+1]=vec3(bv[i].x*w,bv[i].y*h+2,bv[i].z*d+7) end for i=1,b.size do t[#t+1]=bt[i] end
    m.texture=img
    m.vertices=v
    m.texCoords=t
    m:setColors(color(255))
    return m
end





--# Controls
--Controls

--contains Joystick controls and Tilting controls 

--1. Tilting the iPad (not used in this demo)

--This is as easy as just returning the Gravity values, which range from -1 to +1 for both x and y
--You may want to make all three directions incremental [self.mode in Flight tab = (1,1,1)] so you 
--can control how much the plane reacts to tilting, and so you can do 360 degree rolls without
--dislocating your shoulders
function Tilt()
    return vec2(Gravity.x,Gravity.y)
end

--2. Joystick

JoyStick = class()
 
--Note all the options you can set below. Pass them through in a named table
--the damp variable sets a "dead" area in the middle of the joystick where touches don't have an effect
--the default for this is 0.1. This means that sideways or vertical movements don't have any effect until
--they get beyond 10% of the radius away from the centre. The reason is that our fingers are not accurate,
--and if you are just trying to go up, it is difficult to do that without your finger going a little left or right
--and making the plane tip as well. If the middle of the joystick is "dead", your finger doesn't need to be so
--accurate.
function JoyStick:init(t)
    t = t or {}
    self.radius = t.radius or 100  --size of joystick on screen
    self.stick = t.stick or 30 --size of inner circle
    self.centre = t.centre or self.radius * vec2(1,1) + vec2(5,5)
    self.damp=t.damp or vec2(0.1,0.1) --see note above
    self.position = vec2(0,0) --initial position of inner circle
    self.target = vec2(0,0) --current position of inner circle (used when we interpolate movement)
    self.value = vec2(0,0)
    self.delta = vec2(0,0)
    self.mspeed = 60
    self.moving = 0
end
 
function JoyStick:draw()
    ortho()
    viewMatrix(matrix())
    pushStyle()
    fill(160, 182, 191, 50)
    stroke(118, 154, 195, 100)
    strokeWidth(1) 
    ellipse(self.centre.x,self.centre.y,2*self.radius)
    fill(78, 131, 153, 50)
    ellipse(self.centre.x+self.position.x, self.centre.y+self.position.y, self.stick*2)
    popStyle()
end
 
function JoyStick:touched(t)
    if t.state == BEGAN then
        local v = vec2(t.x,t.y)
        if v:dist(self.centre)<self.radius-self.stick then
            self.touch = t.id
        end
    end
    if t.id == self.touch then
        if t.state~=ENDED then
            local v = vec2(t.x,t.y)
            if v:dist(self.centre)>self.radius-self.stick then
                v = (v - self.centre):normalize()*(self.radius - self.stick) + self.centre
            end  --set x,y values for joy based on touch
            self.target=v - self.centre
        else --reset joystick to centre when touch ends
            self.target=vec2(0,0)
            self.touch = false
        end
    end
end
 
function JoyStick:update()
    local p = self.target - self.position
    if p:len() < DeltaTime * self.mspeed then
        self.position = self.target
        if not self.touch then
            if self.moving ~= 0 then
                self.moving = self.moving - 1
            end
        else
            self.moving = 2
        end
    else
        self.position = self.position + p:normalize() * DeltaTime * self.mspeed
        self.moving = 2
    end
    local v=self.position/(self.radius - self.stick)
    return self:Dampen(v)
end

function JoyStick:Dampen(v)
    if not self.damp then return v end
    if v.x>0 then v.x=math.max(0,(v.x-self.damp.x)/(1-self.damp.x))
    else v.x=math.min(0,(v.x+self.damp.x)/(1-self.damp.x)) end
    if v.y>0 then v.y=math.max(0,(v.y-self.damp.y)/(1-self.damp.y))
    else v.y=math.min(0,(v.y+self.damp.y)/(1-self.damp.y)) end
    return v
end
 
function JoyStick:isMoving()
    return self.moving
end
 function JoyStick:isTouched()
    return self.touch
end

--3. Radar

--call this in setup
--it is positioned at bottom right of screen, change if you like

Radar=class()

function Radar:init(f)  
    self.flight=f --instance of Flight for this plane
    self.range=1000 --number of pixels covered by scope radius
    self.radius=105
    self.screenPos=vec2(WIDTH-self.radius-5,self.radius+5)  --position
    self.image=self:CreateRadarImage()
    self.targets={}
end

function Radar:AddTarget(id,f)  --p is vec reference to flight instance
    self.targets[id]=f
end
function RemoveTarget(id)
    table.remove(self.targets,id)
end
 
--create radar screen
function Radar:CreateRadarImage()
    local img=image(self.radius*2,self.radius*2)
    local r=self.radius
    setContext(img)
    pushStyle()
    fill(160, 182, 191, 50)
    stroke(118, 154, 195, 100)
    strokeWidth(1) 
    ellipse(r,r,2*r)
    stroke(0,0,0,100)
    line(r,r-10,r,r+5)
    line(r-10,r,r+10,r)
    line(r-4,r-10,r+4,r-10)
    popStyle()
    setContext()
    return img
end
 
function Radar:draw()
    ortho()
    viewMatrix(matrix())
    pushStyle()
    spriteMode(CENTER)
    sprite(self.image,self.screenPos.x,self.screenPos.y)
    fill(0,0,0,100) 
    local pa=self.flight:position(vec3(0,0,-1))
    local pv=vec2(pa.x,pa.z):normalize()
    for i,o in pairs(self.targets) do
        local d=vec2(self.flight.pos.x,self.flight.pos.z):dist(vec2(o.pos.x,o.pos.z))  --distance
        if d<=self.range then  --only display if on screen
            d=d*self.radius/self.range --calculate distance scaled to radar screen
            --direction from plane to target (without taking plane orientation into account
            local ov=vec2(o.pos.x-self.flight.pos.x,o.pos.z-self.flight.pos.z):normalize()
            --angle between plane orientation and direction from plane to target
            local a=pv:angleBetween(ov)
            ellipse(self.screenPos.x+math.sin(a)*d,self.screenPos.y+math.cos(a)*d,6)
        end
    end
    popStyle()
end


--# Quaternion
--Quaternion class

QC=class()

local sin,cos,pi,rad,deg=math.sin,math.cos,math.pi,math.rad,math.deg
local asin,acos,atan2=math.asin,math.acos,math.atan2
local sqrt,abs,min,max=math.sqrt,math.abs,math.min,math.max

QC.euler={["xyz"]={1,2,3,1},["xzy"]={1,3,2,-1},["yxz"]={2,1,3,-1},
     ["yzx"]={2,3,1,1},["zxy"]={3,1,2,1},["zyx"]={3,2,1,-1}}

QC.t={["xyz"]={-1,1,-1,1},["xzy"]={1,-1,-1,1},["yxz"]={1,1,-1,-1},
     ["yzx"]={-1,1,1,-1},["zxy"]={-1,-1,1,1},["zyx"]={1,-1,1,-1}}

QC.seq,QC.seq2="yxz","yzx"

function QC:init(m,level)
    self.q=vec4(1,0,0,0)
    self.m=m
    self:Reset()
    self.level=level or vec3(0,1,0)
    self.f=0.99
    self.limit=vec3(85,9999,175)
    
end

function QC:Reset()
    self.q=vec4(1,0,0,0)
    self.prevAngles=vec3(0,0,0)
    self.factor=vec3(1,1,1)
end

function QC:RotateDegrees(x,y,z,seq)
    local q1=QC.EulerToQuat(x, y, z, true, seq)
    self.q=QC.Multiply(self.q,q1) 
end

function QC:RotateRadians(x,y,z,seq)
    local q1=QC.EulerToQuat(x, y, z, false, seq)
    self.q=QC.Multiply(self.q,q1) 
end

function QC:draw(v,m)
    v=v or vec3(0,0,0)
    m=m or self.m
    local rm=self:QToMatrix(v)
    pushMatrix()
    modelMatrix(rm)
    m:draw()
    popMatrix()
end

function QC:Move(d) 
    if type(d)=="number" then return self:RotateVector(vec3(0,0,-d)) 
    else return self:RotateVector(d) end
end

function QC:SetRotation(v)
    local m=self:QToMatrix()
    m[13],m[14],m[15]=v:unpack()
    modelMatrix(m)
end

function QC:SetCamera(pos,camPos,rotateZ)
    local c=pos+self:RotateVector(camPos)
    local t=c+self:RotateVector(vec3(0,0,-1)) --camera looks at this point
    local Up
    if rotateZ then Up=self:RotateVector(vec3(0,1,0)) else Up=vec3(0,1,0) end
    --print(camPos)
    camera(c.x,c.y,c.z,t.x,t.y,t.z,Up.x,Up.y,Up.z)
end

function QC:RollLevel()
    if not self.levelling then
        local v=self:RotateVector(vec3(0,0,-1))
        local a=-math.deg(math.atan2(v.x,-v.z))
        self.qt=QC.EulerToQuat(0, a, 0, true)
        self.levelling=true
    end
    self.q=self.Lerp(self.q,self.qt,0.02)
end

function QC:AdjustOrientation(x,y,z)
        self:RotateDegrees(x,y,z)
        self.levelling=nil
end

--helper functions

function QC.EulerToQuat(x,y,z,degrees,seq)
    if degrees then x,y,z=rad(x),rad(y),rad(z) end
    seq=seq or QC.seq
    -- compute all trigonometric values used to compute the quaternion
    local cx,sx = cos(x/2), sin(x/2)
    local cy,sy = cos(y/2), sin(y/2)
    local cz,sz = cos(z/2), sin(z/2)    
    
    local w1, w2 = cx * cy * cz, sx * sy * sz
    local x1, x2 = sx * cy * cz, cx * sy * sz
    local y1, y2 = cx * sy * cz, sx * cy * sz
    local z1, z2 = cx * cy * sz, sx * sy * cz
    
    local t=QC.t[seq]
    return vec4(w1+t[1]*w2,x1+t[2]*x2,y1+t[3]*y2,z1+t[4]*z2)
end

function QC.Multiply(q1,q2,dontNormalise)
    local w1,x1,y1,z1=q1.x,q1.y,q1.z,q1.w
    local w2,x2,y2,z2=q2.x,q2.y,q2.z,q2.w
    local w = w1*w2 - x1*x2 - y1*y2 - z1*z2
    local x = w1*x2 + x1*w2 + y1*z2 - z1*y2
    local y = w1*y2 - x1*z2 + y1*w2 + z1*x2
    local z = w1*z2 + x1*y2 - y1*x2 + z1*w2
    local v=vec4(w,x,y,z)
    if dontNormalise then return v else return v:normalize() end
end

function QC:QToMatrix(v)
    -- calculate coefficients used for building the matrix
    v=v or vec3(0,0,0)
    local w,x,y,z=self.q.x,self.q.y,self.q.z,self.q.w
    local x2,y2,z2 = x + x,y + y,z + z
    local xx,xy,xz = x * x2,x * y2,x * z2
    local yy,yz,zz = y * y2,y * z2,z * z2
    local wx,wy,wz = w * x2,w * y2,w * z2
    return matrix(1-(yy+zz),xy+wz,xz-wy,0,
                  xy-wz,1-(xx+zz),yz+wx,0,
                  xz+wy,yz-wx,1-(xx+yy),0,
                v.x,v.y,v.z,1)
end

function QC:RotateVector(v)
    local w,x,y,z=self.q.x,self.q.y,self.q.z,self.q.w
    local x1 = y*v.z - z*v.y
    local y1 = z*v.x - x*v.z
    local z1 = x*v.y - y*v.x
    local x2 = w*x1 + y*z1 - z*y1
    local y2 = w*y1 + z*x1 - x*z1
    local z2 = w*z1 + x*y1 - y*x1
    return vec3(v.x+2*x2,v.y+2*y2,v.z+2*z2)
end

function QC.LookAtMatrix(source,target,up)
    up=up or vec3(0,1,0)
    local Z=(source-target):normalize()
    local X=(up:cross(Z)):normalize()
    local Y=(Z:cross(X)):normalize()
    return matrix(X.x,X.y,X.z,0,  Y.x,Y.y,Y.z,0,  Z.x,Z.y,Z.z,0,  source.x,source.y,source.z,1)
end

function QC:RotateTowards(source,target,limit,type,up)
    type=type or 1
    local m=QC.LookAtMatrix(source,target,up)
    if not limit then self.q=QC.MatrixToQ(m) return end
    local q2=QC.MatrixToQ(m) 
    local a=QC.AngleBetween(self.q,q2)
    if abs(a)<0.001 then return end
    local u=min(1,rad(limit)/a)
    if type==1 then self.q=QC.Lerp(self.q,q2,u) else self.q=QC.Slerp(self.q,q2,u) end
end

function QC.MatrixToQ(m)
    local w,x,y,z
    local t=1+m[1]+m[6]+m[11]
    if t>0.00000001 then
        local s=sqrt(t)*2 
        x=(m[7]-m[10])/s 
        y=(m[9]-m[3])/s
        z=(m[2]-m[5])/s 
        w=0.25*s 
    else
        if m[1] > m[6]  and m[1] > m[11] then  -- Column 1
            local s  = sqrt( 1.0 + m[1] - m[6] - m[11] ) * 2
            x = 0.25 * s
            y = (m[2] + m[5] ) / s
            z = (m[9] + m[3] ) / s
            w = (m[7] - m[10] ) / s
        elseif m[6] > m[11] then -- Column 2 
            local s  = sqrt( 1.0 + m[6] - m[1] - m[11] ) * 2
            x = (m[2] + m[5] ) / s
            y = 0.25 * s
            z = (m[7] + m[10] ) / s
            w = (m[9] - m[3] ) / s
        else 						--Column 3
            local s  = sqrt( 1.0 + m[11] - m[1] - m[6] ) * 2
            x = (m[9] + m[3] ) / s
            y = (m[7] + m[10] ) / s
            z = 0.25 * s
            w = (m[2] - m[5] ) / s
        end
    end
    return vec4(w,x,y,z)
end

function QC.AngleBetween(q1,q2)
    q1,q2=q1:normalize(),q2:normalize()
    local a=2*acos(q1:dot(q2))
    if not a then a=0 end
    local pi=pi
    if abs(a)>pi then 
        if a>0 then a=2*pi-a else a=-a-2*pi end 
    end
    return a
end

function QC.Lerp(q1,q2,t)
    if q1.x*q2.x+q1.y*q2.y+q1.z*q2.z+q1.w*q2.w<0 then return (q1*(1-t)-q2*t):normalize()
    else return (q1*(1-t)+q2*t):normalize()
    end
end

function QC.Slerp(q1,q2,t)
    local w1,x1,y1,z1,w2,x2,y2,z2=q1.x,q1.y,q1.z,q1.w,q2.x,q2.y,q2.z,q2.w
    local a=acos(q1:dot(q2))
    local sa=sin(a)
    if sa==0 then return q1
    else return ((q1*sin((1-t)*a)+q2*sin(t*a))/sa):normalize() end
end

function QC.MatrixByVector(m,v)
    local x=m[1]*v.x+m[5]*v.y+m[9]*v.z
    local y=m[2]*v.x+m[6]*v.y+m[10]*v.z
    local z=m[3]*v.x+m[7]*v.y+m[11]*v.z
    if v.w then 
        x,y,z=x+m[13],y+m[14],z+m[15] 
        return vec4(x,y,z,1) 
    else return vec3(x,y,z) end 
end