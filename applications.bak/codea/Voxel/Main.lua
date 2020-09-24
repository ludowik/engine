--# Main
--# Main
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(OVERLAY)
    imageSetup()
    BLOCKWIDTH = 20
    TEXTURE = defaultTexture -- readImage("Documents:testTex")
    TEXRANGE = {
        {vec2(0,0),vec2(1,1)}
    }
    TEXINDEX = 1
    COLORS = {
        color(255, 255, 255, 255),
        color(42, 190, 217, 255),
        color(193, 80, 80, 255),
        color(237, 160, 41, 255),
        color(98, 45, 173, 255),
        color(69, 96, 208, 255),
        color(179, 204, 44, 255),
        color(52, 132, 124, 255),
        color(146, 194, 77, 255)}

    parameter.watch("SaveAs")
    parameter.action("SaveMesh",function() saveMesh() end)

    touches = {}
    cam = CameraVoxel()
    ls,rs = Stick(10),Stick(3,WIDTH-120)
    col = COLORS[1]
    model = ModelVoxel()
    ui = Ui()
    mode = "Add"
end

function draw()
    background(40, 40, 50)
    perspective()
    cam:draw()
    drawScene()
    model:draw()
    ortho()
    viewMatrix(matrix())
    ui:draw()
    ls:draw()
    rs:draw()
end

function touched(touch)
    if touch.state == ENDED then
        touches[touch.id] = nil
    else
        touches[touch.id] = touch
    end
    if touch.y <= HEIGHT-40 then
        model:touched(touch)
    else
        ui:touched(touch)
    end
end

function drawScene()
    strokeWidth(2)
    pushMatrix()
    translate(0,-200,0) rotate(90,1,0,0)
    for i = -5,5 do
        line(-500,i*100,500,i*100)line(i*100,-500,i*100,500)
    end
    popMatrix()
end

function imageSetup()
    pushStyle()
    strokeWidth(4)
    fill(0, 0, 0, 255)
    stroke(255, 255, 255, 255)
    ghostImg = image(50,50)
    setContext(ghostImg) rect(-1,-1,52,52) setContext()
    fill(255, 255, 255, 255)
    stroke(0, 0, 0, 255)
    defaultTexture = image(50,50)
    setContext(defaultTexture)
    rect(-1,-1,52,52)
    setContext()
    popStyle()
end

function rRect(w,h,r)
    strokeWidth(0)
    local img = image(w,h)
    fill(255, 255, 255, 255)
    setContext(img)
    pushMatrix()
    ellipse(r/2,h-r/2,r)ellipse(w-r/2,h-r/2,r)
    ellipse(r/2,r/2,r)ellipse(w-r/2,r/2,r)
    rect(0,r/2,w,h-r) rect(r/2,0,w-r,h)
    popMatrix()
    setContext()
    return img
end

function intersectPlane(planePos,planeNorm,a,b)
    local b = b or vec3(0,0,0)
    local ad = (a-planePos):dot(planeNorm)
    local bd = (b-planePos):dot(planeNorm)
    if ad > 0 and bd < 0 or ad < 0 and bd > 0 then
        local intersection = a+((a-b):normalize()*(a:dist(b)/(a-b):dot(-planeNorm)*ad))
        return true,intersection
    end
    return false
end

function saveMesh()
    if SaveAs ~= "" then
        local s = saveMesh()
        saveGlobalData(SaveAs,s)
        
        print('Done, saved to global data using key "'..SaveAs..'"')
        print("Load mesh into a project using...")
        print(
            'data = loadstring(readGlobalData("'..SaveAs..'"))()\n'..
            "m = mesh()\n"..
            "m.vertices = data.vertices\n"..
            "m.colors = data.colors\n"..
            'm.texture = "someTexture"\n'..
            "m.texCoords = data.texCoords"
        )
    else
        print("No name given to save as")
    end
end

function saveMesh()
    print("Copying Data")
    local tempVert,tempCol,tempTex = {},{},{}
    for i = 1,#model.meshVerts do
        table.insert(tempVert,model.meshVerts[i])
        table.insert(tempCol,model.meshColors[i])
        table.insert(tempTex,model.meshTexCoords[i])
    end
    print("Checking Doubles")
    local r = {}
    for i = 1,#tempVert-3,3 do
        local a,b,c = tempVert[i],tempVert[i+1],tempVert[i+2]
        for j = i+3,#tempVert,3 do
            if a == tempVert[j] and b == tempVert[j+1] and c == tempVert[j+2] then
                table.insert(r,i)
                table.insert(r,j)
            end
        end
    end
    print("Sorting")
    table.sort(r,function(a,b)
        return a > b
    end)

    print("Deleting Doubles")
    for k,v in ipairs(r) do
        for i = 1,3 do
            table.remove(tempVert,v)
            table.remove(tempCol,v)
            table.remove(tempTex,v)
        end
    end
    print("Saving")

    local s = "return {"
    s = s.."vertices = {"
    for l,n in ipairs(tempVert) do
        s = s.."vec3("..n.x..","..n.y..","..n.z.."),"
    end
    s = s.."},"
    print("Verts Saved")
    s = s.."colors = {"
    for l,n in ipairs(tempCol) do
        s = s.."color("..n.r..","..n.g..","..n.b..","..n.a.."),"
    end
    s = s.."},"
    print("Colors Saved")
    s = s.."texCoords = {"
    for l,n in ipairs(tempTex) do
        s = s.."vec2("..n.x..","..n.y.."),"
    end
    s = s.."}"
    print("TexCoords Saved")
    s = s.."}"
    return s
end
