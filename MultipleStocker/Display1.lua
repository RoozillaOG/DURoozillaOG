
require "../Ui/UiTable2.lua"
require "../Data/DataGrid.lua"
require "../Data/DataRow.lua"
require "../Data/DataCell.lua"
require "../Industry/IndustryState.lua"

local json = require("dkjson")

local layer = createLayer()
local sx,sy = getResolution()

logMessage("Display data:")
logMessage(json.encode(getInput())) 

-- font name finder 
local numFonts = getAvailableFontCount()
for i = 1,numFonts,1 do
  logMessage(i .. " = " .. getAvailableFontName(i))
end

local layer = createLayer()
local sx,sy = getResolution()

local dataGrid = DataGrid()
dataGrid.FromRowData(json.decode(getInput()))

local font = loadFont("Play", 70)
local y = getFontSize(font)

setNextTextAlign(layer, AlignH_Center, AlignV_Top)
local color = ColorRGBAWhite
setNextStrokeColor(layer, color.r, color.g, color.b, color.a)
addText(layer, font, "Industry Stocker", sx / 2.0, 0.0)

-- set last cell (status) to text instead of index, keeping data size small
for k, v in pairs(dataGrid.GetRows()) do
  v[#v].SetText(IndustryState[v[#v].GetText()])
end

local dataTable = UiTable2(layer, 20.0, y + 20.0, sx - 20.0, sy - 20.0, dataGrid)
dataTable.gridLines = true
dataTable.Draw()

requestAnimationFrame(100)


