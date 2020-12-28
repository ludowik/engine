system = system or {}

function system.release()
end

function system.reset()
    love.graphics.reset()
end

function system.window(w, h)
    assert(w and h)
    
    W, H = w, h or w
    WIDTH, HEIGHT = W, H
    
    love.window.setMode(W_INFO + W, H, {

--            x = 0,
--            y = 0,

            fullscreen = false,
            fullscreentype  = 'desktop', -- 'desktop' or 'exclusive'

            vsync  = true, -- True if LÖVE should wait for vsync, false otherwise.

            msaa  = 0, -- The number of antialiasing samples.

            stencil = true, -- Whether a stencil buffer should be allocated. If true, the stencil buffer will have 8 bits.
            depth = 0, -- The number of bits in the depth buffer.

            resizable = true, -- True if the window should be resizable in windowed mode, false otherwise.
            borderless = false, -- True if the window should be borderless in windowed mode, false otherwise.
            centered = false, -- True if the window should be centered in windowed mode, false otherwise.

            display = 1, -- The index of the display to show the window in, if multiple monitors are available.

            minwidth = 100, -- The minimum width of the window, if it's resizable. Cannot be less than 1.
            minheight = 100, -- The minimum height of the window, if it's resizable. Cannot be less than 1.

            highdpi = false, -- True if high-dpi mode should be used on Retina displays in macOS and iOS. Does nothing on non-Retina displays.

        })
end

function system.setTitle(appPath)
    love.window.setTitle(appPath)
end

function system.getTicks()
    return love.timer.getTime() * 1000
end

function system.getTime()
    return love.timer.getTime()
end

function system.sleep(n)
    love.timer.sleep(n)
end

function system.swap()
end

function system.quit(restartMode)
    love.event.quit(restartMode)
end



function system.getFPS()
    return love.timer.getFPS()
end

function system.frameSyncMode(mode)
    love.window.setVSync(mode and 1 or 0)
end
