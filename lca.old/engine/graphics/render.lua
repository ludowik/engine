function render(context, f)
    pushMatrix()
    do
        noLight()

        resetStyle()
        resetMatrix(true)

        ortho()

        if context then
            setContext(context)
        end

        f()

        if context then
            setContext()
        end
    end
    popMatrix()
end
