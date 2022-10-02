require "RooButton.lua"
require "RooTable.lua"

local layer = createLayer()
local utils = RooUtils:new()
local font = loadFont("Play", 100)
local sx,sy = getResolution()

utils.hitTest()

setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
addText(layer, font, "Hi", sx*0.5, sy*0.3)

logMessage(json)