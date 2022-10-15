
require "../Ui/UiTable.lua"
require "../Ui/ColorRGBA.lua"

local json = require("dkjson")

local layer = createLayer()
local sx,sy = getResolution()

logMessage("Display data:")
logMessage(json.encode(getInput())) 

local font = loadFont("Fun", 100)
local x = getFontSize(font)

setNextTextAlign(layer, AlignH_Left, AlignV_Top)
local color = ColorRGBAWhite
setNextStrokeColor(layer, color.r, color.g, color.b, color.a)
addText(layer, font, "Container Management", 0.0, 0.0)

local dataTable = UiTable(layer, x, 20.0, sx - 20.0, sy - 20.0, json.decode(getInput()))  
dataTable.gridLines = true
dataTable.oddRowColor = ColorRGBA().LightGreen()
dataTable.evenRowColor = ColorRGBA().LightBlue()
dataTable.Draw()

requestAnimationFrame(100)


