requireLib(
    'lexer',
    'parser')

if truea then

    lexer(io.read('./libc/freetype/verra.lua'))

else

    local files = dir('.', isLuaFile, true)
    for i,file in ipairs(files) do
        if not string.find(file, 'verra') then
            print(file)
            lexer(io.read(file))
        end
    end


end
