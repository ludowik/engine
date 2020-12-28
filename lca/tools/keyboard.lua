-- keyboard
function showKeyboard()
    lca.keyboard.setTextInput(true)
end

function hideKeyboard()
    lca.keyboard.setTextInput(false)
end

function isKeyboardShowing()
    return lca.keyboard.hasTextInput()
end
