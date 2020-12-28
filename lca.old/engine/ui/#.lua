ui = {}
setfenv(0, setmetatable(ui, {__index=_G}))

lib('bind',
    'label',
    'expression',
    'button',
    'checkbox',
    'listbox',
    'slider',
    'layout',
    'message',
    'editor',
    'joystick',
    'space',
    'background',
    'advanced',
    'timer',
    'fps'
)
setfenv(0, _G)

lib('bar')
lib('parameter')
