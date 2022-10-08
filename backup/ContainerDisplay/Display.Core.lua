require "../Utils/Utils.lua"
local json = require("dkjson")

local layer = createLayer()
local utils = RooUtils:new()
local font = loadFont("Play", 100)
local sx,sy = getResolution()

setNextTextAlign(layer, AlignH_Left, AlignV_Top)

local items = json.decode(getInput())

--addText(layer, font, items, 0.0, 0.0)

requestAnimationFrame(100)