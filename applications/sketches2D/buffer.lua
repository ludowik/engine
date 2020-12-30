function setup()
    ffiBuffer = BufferLua()
    ffiBuffer[1] = 12
    ffiBuffer[2] = 24
    
    ffiBufferNew = 1
    
    parameter.watch('ffiBufferNew')
    
    parameter.watch('convertMemory(ffiBufferSize * gl.glSizeOfFloat())')
    parameter.watch('convertMemory(#ffiBuffer * gl.glSizeOfFloat())')
    
    parameter.watch('ffiBuffer[1]')
    parameter.watch('ffiBuffer[2]')
    parameter.watch('ffiBuffer[3]')
    parameter.watch('ffiBuffer[4]')

    luaBuffer = {}
    luaBuffer[1] = 12
    luaBuffer[2] = 24
    
    parameter.watch('convertMemory(#luaBuffer * gl.glSizeOfFloat())')
    
    parameter.watch('luaBuffer[1]')
    parameter.watch('luaBuffer[2]')
end

function update(dt)
    if #ffiBuffer > 10^6 then
        ffiBuffers = ffiBuffers or Table()
        ffiBuffers:add(ffiBuffer)
        
        ffiBufferSize = 0
        for i,buf in ipairs(ffiBuffers) do
            ffiBufferSize = ffiBufferSize + #buf
        end
        
        ffiBuffer = BufferLua()
        ffiBuffer[1] = 12
        ffiBuffer[2] = 24
        
        ffiBufferNew = ffiBufferNew + 1
    end
    
    for i =1,10^6 do
        ffiBuffer[#ffiBuffer+1] = random()
        --luaBuffer[#luaBuffer+1] = random()
    end
end

function draw()
    background()
end
