function renderFunction(f, context)
    pushMatrix()
    pushStyle()
    do
        noClip()
        
        noLight()

        resetMatrix(true)
        resetStyle(NORMAL, true, false)

        if context then
            setContext(context)
        end

        f()

        if context then
            setContext()
        end
    end
    popStyle()
    popMatrix()
end
