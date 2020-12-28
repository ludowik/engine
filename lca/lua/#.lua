lua = {}

function doNothing()
end

requireLib(
    'id',
    'debug',
    'decorate',
    'table',
    'class',
    'ut',
    'string',
    'date',
    'array',
    'heap',
    'grid',
    'eval',
    'os',
    'log',
    'ffi_wrapper',
    'bit',
    'buffer',
    'attribs',
    'enum',
    'octree',
    'files',
    'range',
    'dev')

assert(not nil)
assert(nil or false == false)
