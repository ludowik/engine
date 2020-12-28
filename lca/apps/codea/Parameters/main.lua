-- Parameters

-- This example shows off the functionality of the viewer sidebar
-- The sidebar can be filled with interactive widgets, called parameters, that
--  can be adjusted live, while your code is running to affect your result.

-- The below example simply draws a circle and some text, and uses parameters to
--  control the various styles and positions of elements
function setup()
    supportedOrientations(PORTRAIT)
    displayMode(STANDARD)

    -- This creates an editable text parameter
    --  the optional callback at the end simply prints the parameter
    parameter.text("TitleText", "Hello Parameters!", function(t) print(t) end )

    -- This is how you create number parameters 
    --  represented by sliders
    parameter.number("X", 0, WIDTH, WIDTH/2, function(n) print("X set to "..n) end )

    -- Here is a color parameter, you can tap the color sample to
    --  adjust it live, in the viewer. colorChanged is an optional callback
    --  functio we are using
    parameter.color("CircleColor", color(255,128,0,128), colorChanged)

    -- This is a boolean parameter, represented by a switch interface
    --  it defaults to 'true' and we use it to determine whether to draw
    --  a stroke around the circle
    parameter.boolean("HasStroke", true, 
        function(b) 
            print("HasStroke toggled to "..tostring(b)) 
        end ) 

    -- This is an action parameter. It is simply a button in the parameter
    --  list that calls the supplied function when clicked
    parameter.action("Clear Output", function()
            output.clear()
        end)

    -- Here we are watching a simple expression that converts the variable 'TitleText'
    --  into upper case
    parameter.watch("string.upper(TitleText)")

    -- This is an integer parameter, similar to a number parameter
    -- but you don't get the decimal component
    -- Its range is -5 to 5
    parameter.number("StrokeWidth", 0, 10, 5)
end

function colorChanged(c)
    -- In our color callback we just print
    --  the color. How boring!
    print(c)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)

    -- Set up a nice large white font
    fill(255)
    fontSize(40)
    font("AmericanTypewriter-Bold")
    textWrapWidth(WIDTH)

    -- Draw text using the 'TitleText' parameter exposed
    --  in setup() above
    text(TitleText, WIDTH/2, HEIGHT - 100)

    -- Use the 'CircleColor' global exposed by the parameter
    --  defined in setup()
    fill(CircleColor)

    -- Use the integer parameter 'StrokeWidth' to control our
    --  strokeWidth()
    strokeWidth(StrokeWidth * 2)

    -- Use the boolean parameter 'HasStroke' to disable
    --  the stroke
    if not HasStroke then
        noStroke()
    end

    -- Draw a circle at the 'X' position exposed by the number
    --  parameter defined in setup() above
    ellipse(X, HEIGHT/2, 100)
end

function touched(touch)
    -- If the user drags their finger we'll
    --  update the number slider controlling 'X'
    -- This shows how code can affect parameter widgets
    if touch.state == MOVING then
        X = touch.x
    end

    -- Check if the screen has been tapped, if so
    --  toggle the 'HasStroke' variable
    -- We will see the parameter widget update live
    if touch.state == ENDED and touch.tapCount == 1 then
        HasStroke = not HasStroke
    end
end
