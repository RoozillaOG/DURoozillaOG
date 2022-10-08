
----- Display.Core.lua ----
if not RooUtils then
  RooUtils = {}
  RooUtils.__index = RooUtils

  function RooUtils:new()
    local self = {
    }
        
    function self:hitTest(layer, font)

    end

    return self
  end

end

local json = require("dkjson")

local layer = createLayer()
local utils = RooUtils:new()
local font = loadFont("Play", 100)
local sx,sy = getResolution()

setNextTextAlign(layer, AlignH_Left, AlignV_Top)

local items = json.decode(getInput())

--addText(layer, font, items, 0.0, 0.0)

requestAnimationFrame(100)

--------------------------


