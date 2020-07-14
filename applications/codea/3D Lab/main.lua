-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(STANDARD)
 
    availableTests = { Test2(), Test1() }
    currentTest = availableTests[1]

    parameter.integer("SceneSelect",1,#availableTests,1)
    
    parameter.number("lSize", 50, 500, 150)
    parameter.number("CamHeight", 0, 1000, 300)
    parameter.number("Angle",-360, 360, 0)
    parameter.number("FieldOfView", 10, 140, 45)
    
    the3DViewMatrix = viewMatrix()
    parameter.watch("the3DViewMatrix")
    
    -- These watches are evaluated after draw() is finished
    -- Thus the contents are not as interesting
    parameter.watch("viewMatrix()")
    parameter.watch("modelMatrix()")
    parameter.watch("projectionMatrix()")
end

-- This function gets called once every frame
function draw()
    -- Set the currentTest to the selected scene
    currentTest = availableTests[SceneSelect]
    
    -- First arg is FOV, second is aspect
    perspective(FieldOfView, WIDTH/HEIGHT)
 
    -- Position the camera up and back, look at origin
    camera(0,CamHeight,-300, 0,0,0, 0,1,0)
    
    -- Write this into a variable so we can watch() it
    -- at this point in time
    the3DViewMatrix = viewMatrix()
    
    -- This sets a dark background color 
    background(40, 40, 50)

    -- Do your drawing here
    currentTest:draw()    
    
    -- Restore orthographic projection
    ortho()
    
    -- Restore the view matrix to the identity
    viewMatrix(matrix())
    
    -- Draw a label at the top of the screen
    fill(255)
    font("Arial")
    fontSize(30)
    
    text(currentTest:name(), WIDTH/2, HEIGHT - 30)
end