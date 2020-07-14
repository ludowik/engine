-- Animation

-- To see the tween code for these examples, please look in the following tabs:
--
-- 1. 'Basics' for an introduction to tween(), easing types, and callbacks
-- 2. 'Loops' for an introduction to looping tweens
-- 3. 'Sequence' to learn how to chain tweens together to form a sequence
-- 4. 'Path' to learn how to have an object follow a path

function setup()
    supportedOrientations(LANDSCAPE_ANY)
        
    allTests = { Basics(), Loops(), Sequence(), Path() }
    currentTest = nil
    
    parameter.integer("TestNumber", 1, #allTests, 1, setTest)
    
    parameter.action("Start / Reset Animation", function() currentTest:startOrResetAnimations() end)
    
    parameter.watch("currentTest.name")
end

function setTest(index)
    if currentTest ~= nil then
        currentTest:cleanup()
    end
    
    currentTest = allTests[index]
    currentTest:setup()
end

-- This function gets called once every frame
function draw()
    if currentTest then
        currentTest:drawTest()
    end
end

