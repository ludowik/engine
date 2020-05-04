require 'lua'
require 'maths'

if love then
    require 'engine.core_love'
else
    require 'engine.core_lua'
end

require 'engine.mouse'

require 'engine.color'
require 'engine.style'
require ('engine.graphics_'..(love and 'love' or 'lua'))

require 'engine.game_object'

require 'engine.application'
require 'engine.engine'
