
require "../Ui/UiTable2.lua"
require "../Data/DataGrid.lua"
require "../Data/DataRow.lua"
require "../Data/DataCell.lua"
require "../Industry/IndustryData.lua"

local json = require("dkjson")

-- font name finder 
local numFonts = getAvailableFontCount()
for i = 1,numFonts,1 do
  logMessage(i .. " = " .. getAvailableFontName(i))
end

local layer = createLayer()
local sx,sy = getResolution()

local dataGrid = DataGrid()

local dataGrid = IndustryDataToDataGrid(json.decode(getInput()))
local dataTable = UiTable2(layer, 20.0, 20.0, sx - 20.0, sy - 20.0, dataGrid)
dataTable.gridLines = true
dataTable.Draw()

requestAnimationFrame(100)


