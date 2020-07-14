--- performanceCheck

-- Localize, localize ---
-- Avoid table.insert(t, x) => t[i] = x
-- Avoid ipairs(tab) => i=1,#tab
-- Avoid unpack()

--- Math performance ---
-- Multiplication is faster than division
-- Multiplication is faster than exponentiation
-- Modulus operator is fast than math.fmod

-- TODO
function comparePerf(stopAfter)
    if glm then
        performance("matrix",
            function (tab)
                local a = lua_matrix.random()
                local b = lua_matrix.random()
                local c = (a*b):scale(1,2,3):translate(1,1,1):rotate(1, 1,0,0):transpose()
            end,
            function (tab)
                local a = glm_matrix.random()
                local b = glm_matrix.random()
                local c = (a*b):scale(1,2,3):translate(1,1,1):rotate(1, 1,0,0):transpose()
            end)

        performance("vec2",
            function (tab)
                local a = vec2.random()
                local b = vec2.random()
                local c = (a+b)*(a-b)
            end,
            function (tab)
                local a = glm_vec2.random()
                local b = glm_vec2.random()
                local c = (a+b)*(a-b)
            end)
    end

    performance("localisation",
        function (tab)
            local a = nil
            for i=1,#tab do
                a = tab[i]
            end
            a = nil
        end,
        function (tab)
            b = nil
            for i=1,#tab do
                b = tab[i]
            end
            b = nil
        end)

    performance("ipairs vs iteration",
        function (tab)
            for _,item in ipairs(tab) do
                local a = tab[i]
            end
        end,
        function (tab)
            for i=1,#tab do
                local a = tab[i]
            end
        end)

    if stopAfter then
        close()
    end
end
