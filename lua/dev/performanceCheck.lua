--- performanceCheck

-- Localize, localize ---
-- Avoid table.insert(t, x) => t[i] = x
-- Avoid ipairs(tab) => i=1,#tab
-- Avoid unpack()

--- Math performance ---
-- Multiplication is faster than division
-- Multiplication is faster than exponentiation
-- Modulus operator is fast than math.fmod

function comparePerf(stopAfter)
    local b
    tab = {}
    for i=1,100000 do
        tab[i] = i
    end
    
    Performance.compare("localisation",
        function ()
            local a = nil
            for i=1,#tab do
                a = tab[i]
            end
            a = nil
        end,
        function ()
            b = nil
            for i=1,#tab do
                b = tab[i]
            end
            b = nil
        end)

    Performance.compare("ipairs vs iteration",
        function ()
            for _,item in ipairs(tab) do
                local a = tab[i]
            end
        end,
        function ()
            for i=1,#tab do
                local a = tab[i]
            end
        end)

    if stopAfter then
        close()
    end
end
