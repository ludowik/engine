function renderFunction(f, context)
    pushMatrix()
    pushStyle()
    do
        noLight()

        resetMatrix(true)
        resetStyle(NORMAL, false, false)

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
