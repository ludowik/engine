local box2d_def = requireLib 'defs'
local scripPath = ...
box2d = Module(scripPath..'/box2d', 'box2d', box2d_def)

pixelToMeterRatio = 32
mtpRatio = pixelToMeterRatio
ptmRatio = 1 / mtpRatio

requireLib(
    'box2d',
    'body',
    'joint')
