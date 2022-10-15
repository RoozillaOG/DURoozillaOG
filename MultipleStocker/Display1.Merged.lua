

--== start file ..\Ui\UiRow.lua ==--

--==require "./UiCell.lua"

if not UiRow then
  UiRow = {}
  UiRow.__index = UiRow

  function UiRow(cells)
    self = {
      cells = cells or {}
    }

    function self.AddCell(cell) 
      self.cells[#self.cells + 1] = cell
    end

    function self.NumCells()
      return #self.cells
    end

    return self
  end
end

--== end file ..\Ui\UiRow.lua ==--

--== start file ..\Data\DataCell.lua ==--

if not DataCell then
  DataCell = {}
  DataCell.__index = DataCell

  DataCellStatusNormal = "Normal"
  DataCellStatusWarning = "Warning"
  DataCellStatusAlert = "Alert"
  DataCellStatusGood = "Good"

  --@param status string one of Normal, Warning, Alert
  function DataCell(text, status)
    local self = {
      ["data"] = {
        text = text,
        status = status or DataCellStatusNormal
      }
    }

    function self.GetText()
      return self.data.text
    end

    function self.GetStatus()
      return self.data.status
    end

    function self.SetText(value)
      self.data.text = value
    end

    function self.SetStatus(status)
      self.data.status = status
    end

    function self.GetData()
      return self.data
    end

    return self
  end
end

--== end file ..\Data\DataCell.lua ==--

--== start file ..\Ui\UiTable2.lua ==--

--==require "./ColorRGBA.lua"
--==require "../Data/DataGrid.lua"
--==require "../Data/DataCell.lua"
--==require "../Data/DataRow.lua"
--==require "./UiRow.lua"
--==require "./UiCell.lua"

local json = require("dkjson") 

if not UiTable2 then
  UiTable2 = {}
  UiTable2.__index = UiTable2

  ---@param layer any The layer to draw to
  ---@param sx number Starting x location of table
  ---@param sy number Starting y location of table
  ---@param ex number Ending x location of table 
  ---@param ey number Ending y location of table
  ---@param data table A table of rows containing a table of columns to dislay in the table 
  function UiTable2(layer, sx, sy, ex, ey, dataGrid, fontname)
    local self = {
      sx = sx or 0.0,
      sy = sy or 0.0,
      ex = ex or 0.0,
      ey = ey or 0.0,
      dataGrid = dataGrid or nil,
      gridLines = false,
      evenRowColor = nil,
      oddRowColor = nil,
      spacingInPixels = 5,
      pixelsPerFontSize = 1.0,
      maxRowSize = 45,
      fontName = fontname or "RefrigeratorDeluxe",
      fontColor = ColorRGBA().White()
    }
        
    if(ex == nil) then 
      self.ex, self.ey = getResolution()
    end

    local fontOne = loadFont(self.fontName, 50)
    local fontTwo = loadFont(self.fontName, 100)
    self.pixelsPerFontSize = (100 - 50) / (getFontSize(fontTwo) - getFontSize(fontOne))

    function self.Draw()
      local numRows = self.dataGrid.NumRows()

      local rowHeightInPixels = (ey - sy) / numRows
      if(rowHeightInPixels > self.maxRowSize) then
        rowHeightInPixels = self.maxRowSize
      end

      local textHeightInPixles = rowHeightInPixels - self.spacingInPixels
      local fontSize = textHeightInPixles / self.pixelsPerFontSize

      local font = loadFont(self.fontName, fontSize)
      local cy = sy
      local numColumns = self.dataGrid.NumColumns()
      local colWidth = (ex - sx) / numColumns
      local rowNumOdd = true
      for kRow, vRow in pairs(self.dataGrid.GetRows()) do
        local cx = sx
        for kCell, vCell in pairs(vRow.GetCells()) do
          self.DrawCell(layer, vCell, font, cx, cy, colWidth, rowHeightInPixels)
          cx = cx + colWidth
        end
        cy = cy + rowHeightInPixels
      end
    end

    function self.DrawCell(layer, cell, font, sx, sy, width, height)
      local notification = cell.GetNotification()
      local fillColor = ColorRGBABlack

      logMessage("Notification: " .. DataCellStatusAlert .. " = " .. json.encode(notification))
      if(notification == DataCellStatusGood) then
        fillColor = ColorRGBALightGreen      
      elseif(notification == DataCellStatusWarning) then
        fillColor = ColorRGBALightYellow
      elseif(notification == DataCellStatusAlert) then
        fillColor = ColorRGBALightRed
      end
      
      setNextFillColor(layer, fillColor.r, fillColor.g, fillColor.b, fillColor.a)
      addBox(layer, sx, sy, width, height)
  
      setNextTextAlign(layer, AlignH_Left, AlignV_Top)
      setNextStrokeColor(layer, ColorRGBAWhite.r, ColorRGBAWhite.g, ColorRGBAWhite.b, ColorRGBAWhite.a)
      logMessage("Cell " .. json.encode(cell.GetData()))
      addText(layer, font, cell.GetText(), sx, sy)
    end

    return self
  end
end

--== end file ..\Ui\UiTable2.lua ==--

--== start file ..\Industry\IndustryState.lua ==--

if not IndustryState then
  IndustryState = {
   [1] = "Stopped",
   [2] = "Running",
   [3] = "Missing Ingredient",
   [4] = "Ouptut Full",
   [5] = "No Output Container",
   [6] = "Pending",
   [7] = "Missing Schematic" 
  }
end

--== end file ..\Industry\IndustryState.lua ==--

--== start file ..\Data\DataGrid.lua ==--

--==require "./DataRow.lua"
--==require "./DataCell.lua"

if not DataGrid then
  DataGrid = {}
  DataGrid.__index = DataGrid

  function DataGrid(rows)
    self = {
      ["data"] = {
        rows = rows or {}
      }
    }

    function self.AddRow(row)
      self.data.rows[#self.data.rows + 1] = row
    end

    function self.NumColumns()
      if(#self.rows > 0) then
        return self.data.rows[0].NumCells()
      end

      return 0
    end

    function self.Encode()
      local data = {}
      for k, v in pairs(self.data.rows) do
        data[#data + 1] = v.GetData()
      end
            
      return json.encode(data)
    end

    function self.FromRowData(rows)
      for kRow, vRow in pairs(rows) do
        local row = DataRow()
        row.FromData(vRow)
        self.data.rows[#self.data.rows + 1] = row
      end
    end

    function self.Decode(json)
      obj = json.decode(json)
      for kRow, vRow in pairs(obj) do
        local row = DataRow()
        row.FromData(vRow)
        self.data.rows[#self.data.rows + 1] = row
      end
    end

    return self
  end
end

--== end file ..\Data\DataGrid.lua ==--

--== start file ..\Data\DataRow.lua ==--

--==require "./DataCell.lua"
json = require("dkjson")

if not DataRow then
  DataRow = {}
  DataRow.__index = DataRow

  function DataRow(cells)
    local self = {
      ["data"] = {
        cells = cells or {}
      }
    }

    function self.AddCell(cell) 
      self.data.cells[#self.data.cells + 1] = cell
    end

    function self.NumCells()
      return #self.data.cells
    end

    function self.GetCells()
      return self.data.cells
    end
        
    function self.Encode()
      return json.encode(self.data.cells)
    end
        
    function self.GetData()
      local data = {}
      for k, v in pairs(self.data.cells) do
        data[#data + 1] = v.GetData()
      end
            
      return data
    end

    function self.FromData(row)
      for kRow, kValue in pairs(row) do
        self.data.cells[#self.data.cells + 1] = UiCell(kValue.text, kValue.status)
      end
    end

    return self
  end
end

--== end file ..\Data\DataRow.lua ==--

--== start file ..\Ui\ColorRGBA.lua ==--

if not ColorRGBA then
  ColorRGBA = {}
  ColorRGBA.__index = ColorRGBA

  function ColorRGBA(r, g, b, a)
    local self = {
      r = r or 0,
      g = g or 0,
      b = b or 0,
      a = a or 1.0
    }

    function self.LightGreen() return ColorRGBA(0.0, 0.3, 0.0, 0.3) end
    function self.LightRed() return ColorRGBA(0.3, 0.0, 0.0, 0.3) end
    function self.LightBlue() return ColorRGBA(0.0, 0.0, 0.3, 0.3) end
    function self.White() return ColorRGBA(0.7, 0.7, 0.7, 0.8) end
    function self.Black() return ColorRGBA(0.0, 0.0, 0.0, 0.8) end

    return self
  end
    
    
  ColorRGBALightGreen = ColorRGBA(0.0, 0.3, 0.0, 0.3)
  ColorRGBALightRed = ColorRGBA(0.3, 0.0, 0.0, 0.3)
  ColorRGBALightBlue = ColorRGBA(0.0, 0.0, 0.3, 0.3)
  ColorRGBALightYellow = ColorRGBA(0.9, 0.7, 0.0, 0.3)
  ColorRGBAWhite = ColorRGBA(0.7, 0.7, 0.7, 0.8)
  ColorRGBABlack = ColorRGBA(0.0, 0.0, 0.0, 0.8) 
    
end

--== end file ..\Ui\ColorRGBA.lua ==--

--== start file ..\Ui\UiCell.lua ==--

--==require "./ColorRGBA.lua"

if not UiCell then
  UiCell = {}
  UiCell.__index = UiCell

  UiCellStatusNormal = "Normal"
  UiCellStatusWarning = "Warning"
  UiCellStatusAlert = "Alert"
  UiCellStatusGood = "Good"

  --@param status string one of Normal, Warning, Alert
  function UiCell(font, data, status)
    self = {
      data = data,
      font = font,
      fontColor = ColorRGBAWhite,
      fillColor = ColorRGBABlack,
      status = status or UiCellStatusNormal
    }
  
    if(status == UiCellStatusGood) then
      self.fillColor = ColorRGBALightGreen      
    elseif(status == UiCellStatusWarning) then
      self.fillColor = ColorRGBALightYellow
    elseif(status == UiCellStatusAlert) then
      self.fillColor = ColorRGBALightRed
    end
    return self
  end

  function Draw(layer, fontSize, sx, sy, width, height)
    setNextFillColor(layer, self.fillColor.r, self.fillColor.g, self.fillColor.b, self.fillColor.a)
    addBox(layer, sx, sy, width, height)

    setNextTextAlign(layer, AlignH_Left, AlignV_Top)
    setNextStrokeColor(layer, self.fontColor.r, self.fontColor.g, self.fontColor.b, self.fontColor.a)
    addText(layer, self.font, data, sx, sy)
  end

end

--== end file ..\Ui\UiCell.lua ==--


--== start file .\Display1.lua ==--

--==require "../Ui/UiTable2.lua"
--==require "../Data/DataGrid.lua"
--==require "../Data/DataRow.lua"
--==require "../Data/DataCell.lua"
--==require "../Industry/IndustryState.lua"

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

--== end file .\Display1.lua ==--

