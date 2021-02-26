require 'lua.class'
require 'lua.string'
require 'lua.table'
require 'lua.array'
require 'lua.path'
require 'lua.fs'

function io.read(path)
    local file = io.open(path, 'r')
    if file then
        local content = file:read('*a')
        file:close()
        return content
    end
end

function lexer(source)
    source = source:gsub("\\\'", "''") -- TOFIX
    source = source:gsub('\\\"', '""') -- TOFIX
    
    source = source:gsub('\\\\', '') -- TOFIX
    
    local tokens = {}

    -- magic characters :  ( ) . % + - * ? [ ^ $
    local patterns = {
        {'comment'    , '%-%-%[%[.-%]%]'},
        {'comment'    , '(%-%-.-)\n'},
        {'new line'   , '\n'},
        {'tab'        , '    '},
        {'space'      , '%s+'},
        {'string'     , '%b""'},
        {'string'     , "%b''"},
        {'string'     , '%[%[.-%]%]'},
        {'concatenate', '%.%.'},
        {'id'         , '[%a_]+'},
        {'number'     , '%d+'},
        {'operator'   , '[%%%^%+%-%*%/]'},
        {'parenthese' , '[%(%)]'},
        {'punctuation', '[%.:{}%[%],;]'},
        {'count'      , '[#]'},
        {'compare'    , '<'},
        {'compare'    , '<='},
        {'compare'    , '>'},
        {'compare'    , '>='},
        {'equal'      , '=='},
        {'distinct'   , '~='},
        {'assign'     , '='},
    }
    
    local keywords = {
        'local',
        'function',
        'if', 'then', 'elseif', 'else', 'end',
        'for', 'in', 'do', 'break',
        'while',
        'repeat', 'until',
        'return',
        'true', 'false'
    }        

    function searchForPattern(source, pattern, pos)
        local search = '^'..pattern[2]

        local startPos, endPos = string.find(source, search, pos)

        if startPos == pos then

            local token = string.match(source, search, pos)

--            for i=1,#token do
--                print(string.byte(token, i))
--            end

            table.insert(tokens, {
                    type = pattern[1],
                    token = token
                })

            return endPos - startPos + 1

        end
        return 0
    end

    local pos = 1
    while true do
        find = false
        
        for i,keyword in ipairs(keywords) do
            len = searchForPattern(source, {'keyword',keyword}, 1)
            if len > 0 then
                pos = pos + len
                source = source:mid(len+1)
                find = true
                break
            end
        end
    
        for i,pattern in ipairs(patterns) do
            len = searchForPattern(source, pattern, 1)
            if len > 0 then
                pos = pos + len
                source = source:mid(len+1)
                find = true
                break
            end
        end
        
        if not find then
            break
        end
    end

    if #source > 0 then
        local infos = ''
        for i,token in ipairs(tokens) do
            if token.type == 'new line' then
                infos = infos..'\n'
            elseif token.type == 'tab' then
                infos = infos..' '
            elseif token.type == 'space' then
                infos = infos..' '
            else
                infos = infos..'['..token.type..':'..token.token..']'..'\n'
            end
        end
        print(infos)

        local toparse = ''
        for i,token in ipairs(tokens) do
            toparse = toparse..token.token
        end

        print(toparse:right(200))
        print('================')
        print(source:left(50))

        assert()

    else
        local infos = ''
        for i,token in ipairs(tokens) do
            if token.type == 'new line' then
                infos = infos..'\n'
            elseif token.type == 'tab' then
                infos = infos..' '
            elseif token.type == 'space' then
                infos = infos..' '
            else
                infos = infos..'['..token.type..':'..token.token..']'..'\n'
            end
        end
--        print(infos)
    end
end

if false then

    lexer('--[[Is the line segment a-b over c-d when seen from e?]]')

else

    local files = dir('.', isLuaFile, true)
    for i,file in ipairs(files) do
        print(file)
        lexer(io.read(file))
    end


end
